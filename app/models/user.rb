# email, string, unique, present
# username, string, unique, present
# password_digest, string, unique, present
# session_token, string, unique, present
# activated, boolean, unique, present
# activation_token, string, unique, present

class User < ApplicationRecord
  attr_reader :password

  validates :email, :username, :password_digest, :session_token, :activation_token, presence: true
  validates :email, :username, :session_token, :activation_token, unique: true

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
end