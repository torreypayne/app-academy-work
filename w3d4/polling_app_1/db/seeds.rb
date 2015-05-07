# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(user_name: 'Bobby_jones')
User.create!(user_name: 'Sandra_jones')
User.create!(user_name: 'Other_bobby')

Poll.create!(title: 'Who is the best?', author_id: 1)
  Question.create!(poll_id: 1, text: 'Me?')
    AnswerChoice.create!(answer_text: 'Yes', question_id: 1)
      Response.create!(user_id: 2, answer_choice_id: 1)

    AnswerChoice.create!(answer_text: 'No', question_id: 1)
      Response.create!(user_id: 2, answer_choice_id: 2)

  Question.create!(poll_id: 1, text: 'You?')

    AnswerChoice.create!(answer_text: 'Yes', question_id: 2)
      Response.create!(user_id: 2, answer_choice_id: 3)

    AnswerChoice.create!(answer_text: 'Maybe', question_id: 2)
      Response.create!(user_id: 2, answer_choice_id: 4)


Poll.create!(title: 'Who is the second best?', author_id: 2)

  Question.create!(poll_id: 2, text: 'Nobody?')
  Question.create!(poll_id: 2, text: 'Sandra??')
