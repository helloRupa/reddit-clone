# title           string      required    unique
# description     text        required
# moderator       integer     required

class Sub < ApplicationRecord
  include Ordering
  EXCERPT_LENGTH = 247

  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true, length: { minimum: MIN_TITLE, maximum: MAX_TITLE }, format: { with: URL_SAFE_REGEX, 
    message: 'allows only letters, numbers, and symbols -_$.+!*()' }
  
  belongs_to :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :moderator

  has_many :post_subs

  has_many :posts,
    through: :post_subs

  def to_param
    self.title
  end

  def add_moderator(user_id)
    self.moderator = user_id
  end

  def excerpt
    self.description.length <= EXCERPT_LENGTH ? self.description : self.description[0..EXCERPT_LENGTH] + '...'
  end
end