# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  body       :string           not null
#  visibility :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#

class Goal < ActiveRecord::Base
  validates :user_id, :body, :title, :status, presence: true
  validates :visibility, inclusion: ["Public", "Private"]
  after_initialize :ensure_visibility, :ensure_status


  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  def ensure_visibility
    self.visibility ||= "Public"
  end

  def ensure_status
    self.status ||= "In Progress"
  end

end
