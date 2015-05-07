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
        polls.*, COUNT(questions.id)
      FROM
        polls
      JOIN
        questions ON poll.id = questions.poll_id # Where we stopped!!
      JOIN
        responses ON responses.user_id = user.id
      JOIN
        answer_choices ON responses.answer_choice_id = answer_choices.id
      JOIN
        polls ON questions.poll_id = polls.id
      WHERE
        user.id = ?
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(responses.id)
    SQL
  end
end
