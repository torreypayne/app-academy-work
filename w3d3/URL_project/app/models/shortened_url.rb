# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
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
    Proc.new { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :topics,
    through: :taggings,
    source: :topic
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
    ShortenedUrl.create!(long_url: long_url,short_url: new_url, submitter_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    user_ids = []
    self.visits.each do |visit|
      user_ids << visit.user_id if visit.created_at <= 10.minutes.ago
    end

    user_ids.uniq.count
  end
end

torrey = User.first
jade = User.second
u1 = ShortenedUrl.first
u2 = ShortenedUrl.second
