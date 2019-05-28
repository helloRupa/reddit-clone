# email,            string,     unique, present
# username,         string,     unique, present
# password_digest,  string,             present
# session_token,    string,     unique, present
# activated,        boolean,            present
# activation_token, string,             present

class User < ApplicationRecord
  include Calcs

  attr_reader :password

  validates :email, :username, :password_digest, :session_token, :activation_token, presence: true
  validates :email, :username, :session_token, :activation_token, uniqueness: true
  validates :password, length: { minimum: MIN_PWORD, allow_nil: true }
  validates :username, length: { minimum: MIN_UNAME, maximum: MAX_UNAME }, format: { with: URL_SAFE_REGEX, 
      message: 'allows only letters, numbers, and symbols -_$.+!*()' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_initialize :ensure_session_token, :ensure_activation_token

  before_destroy :reassign_entries

  has_many :subs,
    class_name: 'Sub',
    primary_key: :id,
    foreign_key: :moderator

  has_many :posts,
    class_name: 'Post',
    primary_key: :id,
    foreign_key: :author_id

  has_many :comments,
    class_name: 'Comment',
    primary_key: :id,
    foreign_key: :author_id

  def reassign_entries
    account_id = User.find_by_username(DESTROYED).id

    User.transaction do
      self.subs.each do |sub|
        sub.moderator = account_id
        sub.save!
      end

      self.posts.each do |post|
        post.author_id = account_id
        post.save!
      end

      self.comments.each do |comment|
        comment.author_id = account_id
        comment.save!
      end
    end
  end

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
    self.activation_token ||= self.class.generate_activation_token
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
    token = SecureRandom::urlsafe_base64(16)

    token = SecureRandom::urlsafe_base64(16) while User.find_by_session_token(token)
    token
  end

  def self.generate_activation_token
    token = SecureRandom::urlsafe_base64(16)

    token = SecureRandom::urlsafe_base64(16) while User.find_by_activation_token(token)
    token
  end

  def self.find_by_credentials(email, pw)
    user = User.find_by_email(email)
    user && user.is_password?(pw) ? user : nil
  end
end