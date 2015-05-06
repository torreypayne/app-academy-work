# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :string
#  created_at   :datetime
#  updated_at   :datetime
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  # validates :long_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :user
  )

  include SecureRandom
  def self.random_code
    new_url = SecureRandom::urlsafe_base64
    until !ShortenedUrl.exists?(short_url: new_url)
      new_url = SecureRandom::urlsafe_base64
    end

    new_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_url = ShortenedUrl.random_code
    ShortenedUrl.create!(long_url: long_url,short_url: new_url,submitter_id: user.id)
  end
end
