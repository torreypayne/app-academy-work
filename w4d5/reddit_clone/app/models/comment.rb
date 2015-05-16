class Comment < ActiveRecord::Base
  validates :content, :author_id, :commentable_type, :commentable_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  belongs_to :commentable, polymorphic: true

  belongs_to(
    :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )

  has_one :post, through: :commentable

  has_many(
    :child_comments,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )


end
