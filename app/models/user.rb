# email,            string,     unique, present
# username,         string,     unique, present
# password_digest,  string,             present
# session_token,    string,     unique, present
# activated,        boolean,            present
# activation_token, string,             present

class User < ApplicationRecord
  attr_reader :password

  validates :email, :username, :password_digest, :session_token, :activation_token, presence: true
  validates :email, :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :username, length: { minimum: 3, maximum: 20 }, format: { with: URL_SAFE_REGEX, 
      message: 'allows only letters, numbers, and symbols -_$.+!*()' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_initialize :ensure_session_token, :ensure_activation_token

  def to_param
    self.username
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def activate_user
    self.activated = true
    self.save!
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, pw)
    user = User.find_by_email(email)
    user && user.is_password?(pw) ? user : nil
  end
end