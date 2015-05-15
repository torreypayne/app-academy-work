# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: 'tpayne@payne.com', password: 'password')
User.create!(email: 'jackie@payne.com', password: 'password')

Band.create!(name: "Three 6 Mafia")
Band.create!(name: "Boyz II Men")
Band.create!(name: "Blackstreet")
Band.create!(name: "Jay-Z")

Album.create!(band_id: 1, album_name: "Most Known Unknown", studio: "Studio")
Album.create!(band_id: 1, album_name: "Underground Vol. 3", studio: "Studio")
Album.create!(band_id: 1, album_name: "Mystic Stylez", studio: "Studio")
Album.create!(band_id: 1, album_name: "In Concert", studio: "Live")
Album.create!(band_id: 2, album_name: "Evolution", studio: "Studio")
Album.create!(band_id: 2, album_name: "The Remix Collection", studio: "Live")
Album.create!(band_id: 2, album_name: "Boyz II Men", studio: "Studio")
Album.create!(band_id: 2, album_name: "Full Circle", studio: "Studio")
Album.create!(band_id: 3, album_name: "No Diggity: The Very Best of Blackstreet", studio: "Studio")
Album.create!(band_id: 3, album_name: "Finally", studio: "Studio")
Album.create!(band_id: 3, album_name: "Another Level", studio: "Studio")
Album.create!(band_id: 4, album_name: "Reasonable Doubt", studio: "Studio")
Album.create!(band_id: 4, album_name: "The Blueprint", studio: "Studio")
Album.create!(band_id: 4, album_name: "MTV Unplugged", studio: "Live")

Track.create!(track_name: "Stay Fly", album_id: 1, kind: "Regular")
Track.create!(track_name: "Roll With It", album_id: 1, kind: "Regular")
Track.create!(track_name: "Don't Violate", album_id: 1, kind: "Regular")
Track.create!(track_name: "Swervin", album_id: 1, kind: "Regular")
Track.create!(track_name: "Knock Tha Black Off Yo Ass", album_id: 1, kind: "Regular")
Track.create!(track_name: "I'll Make Love To You", album_id: 7, kind: "Regular")
Track.create!(track_name: "On Bended Knee", album_id: 7, kind: "Bonus")
Track.create!(track_name: "Thank You", album_id: 7, kind: "Bonus")
Track.create!(track_name: "Ain't No Nigga", album_id: 12, kind: "Bonus")
Track.create!(track_name: "Can't Knock The Hustle", album_id: 12, kind: "Bonus")
Track.create!(track_name: "Dead Presidents", album_id: 12, kind: "Bonus")
Track.create!(track_name: "Regrets", album_id: 12, kind: "Bonus")
