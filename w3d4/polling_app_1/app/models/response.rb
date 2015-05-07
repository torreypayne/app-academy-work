class Response < ActiveRecord::Base
  validate :user_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

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

  def user_has_not_already_answered_question
    if sibling_responses.exists?(user_id: user.id)
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
end
