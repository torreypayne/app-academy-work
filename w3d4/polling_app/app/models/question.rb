class Question < ActiveRecord::Base
  validates :text, presence: true
  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    question_results = {}
    answer_choices.each do |answer_choice|
      question_results[answer_choice] = answer_choice.responses.size
    end

    question_results
  end

  def super_sql_results
    Question.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.*, COUNT(*) AS response_count
      FROM
        questions
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        questions.id = ?
      GROUP BY
        answer_choice_id

    SQL
  end

  def active_record_sql_results
    my_results = answer_choices.select("answer_choices.*, COUNT(*) AS response_count")
      .joins(
      "LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .where("question_id = ?", id)
      .group(:answer_choice_id)

    my_results.inject({}) do |results, answer_choice|
      results[answer_choice.id] = answer_choice.response_count
      results
    end
  end
end
