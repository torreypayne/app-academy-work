# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TOPICS =
"#maloroeselcambio,
#otrosonoraya,
#beyhive4music,
#barbz4music,
#teamcouchetard,
#mtvhitariana,
#teaminsomniaque,
#bola,
#scottssimplesteps,
#interfanscocacolafm,
#jakegivemetickets,
#ucv,
#pssi,
#skwparty,
#askluba,
#futboltotaldirectv,
#somosoclubedafe,
#arianators4music,
#mtvinstalali,
#views,
#swifties4music,
#iwantmerch,
#wooyoung,
#cavsbulls,
#askjoey,
#colorado,
#followmewill,
#minisite,
#survivor,
#imnotsickijust,
#tushytalk,
#handmadehourusa,
#dembows,
#osdezmandamentos033,
#gotseason5,
#trippyteam,
#gucciforpresident,
#clipe7bilhoesbcc,
#mtvdiyppmusas,
#enelaire222".split(",\n")

User.create!(email: 'example1@example.com')
User.create!(email: 'example2@example.com')
User.create!(email: 'example3@example.com')
User.create!(email: 'example4@example.com')
User.create!(email: 'example5@example.com')
User.create!(email: 'example6@example.com')
User.create!(email: 'example7@example.com')
User.create!(email: 'example8@example.com')
User.create!(email: 'example9@example.com')
User.create!(email: 'example10@example.com')
User.create!(email: 'example11@example.com')
User.create!(email: 'example12@example.com')
User.create!(email: 'example13@example.com')
User.create!(email: 'example14@example.com')
User.create!(email: 'example15@example.com')
User.create!(email: 'example16@example.com')
User.create!(email: 'example17@example.com')
User.create!(email: 'example18@example.com')
User.create!(email: 'example19@example.com')
User.create!(email: 'example20@example.com')
User.create!(email: 'example21@example.com')

User.all.each do |user|
  20.times do |n|
    ShortenedUrl.create_for_user_and_long_url!(
      user,
      "fake_url#{n}_by_#{user.email[7, 2]}.com"
    )
  end
end

User.all.each do |user|
  100.times do
    url = ShortenedUrl.all.sample
    Visit.record_visit!(user, url)
  end
end

TOPICS.each do |topic|
  TagTopic.create!(topic: topic)
end

ShortenedUrl.all.each do |url|
  20.times do
    sample_topic = TagTopic.all.sample
    Tagging.create!(topic_id: sample_topic.id, url_id: url.id)
  end
end
