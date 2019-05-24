# title           string      required    unique
# description     text        required
# moderator       integer     required

class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true, length: { minimum: MIN_TITLE, maximum: MAX_TITLE }, format: { with: URL_SAFE_REGEX, 
    message: 'allows only letters, numbers, and symbols -_$.+!*()' }
  
  belongs_to :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :moderator

  has_many :posts

  def to_param
    self.title
  end

  def add_moderator(user_id)
    self.moderator = user_id
  end
end