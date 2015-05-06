puts "Input your email: "
email = gets.chomp
user = User.find_by(email: email)
puts "What do you want to do?
0. Create Shortened URL
1. Visit shortened URL."
response_1 = Integer(gets)
if response_1 == 0
  puts "Type in your long url"
  long_url = gets.chomp
  ShortenedUrl.create_for_user_and_long_url!(user, long_url)
  shortened_url = ShortenedUrl.last.short_url
  puts "Short url is : #{shortened_url}"
else
  puts "Type in the shortened URL"
  short_url = gets.chomp
  long_url = ShortenedUrl.find_by(short_url: short_url).long_url
  Launchy.open(long_url)
end
