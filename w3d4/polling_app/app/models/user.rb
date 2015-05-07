class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  has_many(:polls, class_name: 'Poll', foreign_key: :author_id, primary_key: :id)
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
   :answer_choices,
   through: :responses,
   source: :answer_choice
  )

  def completed_polls
    Poll.find_by_sql([<<-SQL, id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        responses.user_id = ? OR responses.user_id IS NULL
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(responses.id)
    SQL
  end

  def completed_polls_ar
    Poll.select('polls.*').joins(:answer_choices)
      .joins('LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .where('responses.user_id = ?', id)
      .group(:poll_id)
      .having('COUNT(questions.id) = COUNT(responses.id)')
  end

  def uncompleted_polls_ar
    Poll.select('polls.*').joins(:answer_choices)
      .joins('LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .where('responses.user_id = ? OR responses.user_id IS NULL', id)
      .group(:poll_id)
      .having('COUNT(DISTINCT questions.id) > COUNT(DISTINCT responses.id)')
  end
end
