# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  after_initialize :ensure_session_token
  attr_accessor :password

  has_many(:goals,
    class_name: 'Goal',
    foreign_key: :user_id,
    primary_key: :id
    )

  def self.find_by_credentials(un, pw)
    user = User.find_by(username: un)

    if user && user.valid_password?(pw)
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token= SecureRandom.urlsafe_base64(16)
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

end
