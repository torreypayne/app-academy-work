class User < ActiveRecord::Base
  has_many(
  :contacts,
  class_name: 'Contact',
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many :contact_shares
  has_many(
  :shared_contacts,
  through: :contact_shares,
  source: :contact
  )

  validates :username, presence: true, uniqueness: true
end
