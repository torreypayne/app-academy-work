class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  # TA: validate :sub presence


  has_many :post_subs
  has_many :subs, through: :post_subs
  has_many :comments, as: :commentable

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )
end
