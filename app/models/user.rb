# email,            string,     unique, present
# username,         string,     unique, present
# password_digest,  string,             present
# session_token,    string,     unique, present
# activated,        boolean,            present
# activation_token, string,             present

class User < ApplicationRecord
  attr_reader :password

  validates :email, :username, :password_digest, :session_token, :activation_token, presence: true
  validates :email, :username, :session_token, unique: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :username, length: { minimum: 3 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
end