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
  :submitted_user,
  class_name: 'User',
  foreign_key: :submitter_id,
  primary_key: :id
  )

  include SecureRandom
  def self.random_code
    SecureRandom::urlsafe_base64
  end
end
