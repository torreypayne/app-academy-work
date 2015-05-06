# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  url_id     :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Visit < ActiveRecord::Base

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, url_id: shortened_url.id)
  end
end
