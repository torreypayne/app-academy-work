# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  body       :string           not null
#  visibility :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    user_id 1
    title { Faker::Company.bs }
    body { Faker::Company.bs }
    visibility "Public"
  end
end

# goal = FactoryGirl.build(:goal)
