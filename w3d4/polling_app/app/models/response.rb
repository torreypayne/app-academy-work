class Response < ActiveRecord::Base
  validate :user_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll_one_query

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_one(
    :poll,
    through: :question,
    source: :poll
  )

  def user_has_not_already_answered_question
    if sibling_responses_one_query.any? { |obj| obj.user_id == user_id }
      errors.add(:question, "already answered by user")
    end
  end

  def sibling_responses
    if persisted?
      question.responses.where('responses.id != ?', id)
    else
      question.responses.where('responses.id IS NOT NULL')
    end
  end

  def author_cannot_respond_to_own_poll
    if question.poll.author.id == user.id
      errors.add(:response, "cannot be made to own poll")
    end
  end

  def author_cannot_respond_to_own_poll_one_query
    if Response.joins(:user).joins(:poll)
      .where('polls.author_id = users.id').any?
      errors.add(:response, "cannot be made to own poll")
    end
  end

  def sibling_responses_one_query
    if !persisted? # Make sure User only picks one answer to question.
      Response.find_by_sql([<<-SQL, answer_choice_id])
      SELECT
        responses.*
      FROM
        responses
      JOIN
        answer_choices ON responses.answer_choice_id = answer_choices.id
      JOIN
        questions ON answer_choices.question_id = questions.id
      JOIN
        responses as again_responses ON answer_choices.id = again_responses.answer_choice_id
      WHERE
        again_responses.id IS NOT NULL AND answer_choices.id = ?
      SQL
    end

    # Response.select('responses.*').joins(:answer_choice)
    #   .where('answer_choices.id = ?', answer_choice_id)
    #   .joins(:question)
    #   .joins(<<-SQL
    #
    #   )
  end
end
