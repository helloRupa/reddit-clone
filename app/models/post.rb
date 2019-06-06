# title       string        required
# url         text
# content     text
# sub_id      integer       required
# author_id   integer       required

class Post < ApplicationRecord
  include Ordering
  include Calcs
  include Voteable

  EXCERPT_LENGTH = 197
  LONG_EXCERPT_LENGTH = 997

  validates :title, :slug, presence: true
  validates :title, length: { minimum: MIN_POST, maximum: MAX_POST }
  before_validation :add_slug, :check_sub
  before_create :final_slug

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author_id

  has_many :post_subs, 
    inverse_of: :post,
    dependent: :destroy

  has_many :subs,
    through: :post_subs

  has_many :comments,
    dependent: :destroy

  has_many :moderators,
    -> { distinct },
    through: :subs,
    source: :user

  def top_level_comments
    self.comments.where(parent_column_id: nil)
  end

  def check_sub
    errors.add(:post, 'must belong to 1-3 subs') unless self.subs.length.between?(1, 3)
  end

  def to_param
    "#{self.id}-#{self.slug}"
  end

  def final_slug
    self.slug = self.title.parameterize
  end

  def add_slug
    self.slug ||= self.title.parameterize
  end

  def excerpt
    return self.content if self.content.nil? || self.content.length <= EXCERPT_LENGTH
    self.content[0..EXCERPT_LENGTH] + '...'
  end

  def long_excerpt
    return self.content if self.content.nil? || self.content.length <= LONG_EXCERPT_LENGTH
    self.content[0..LONG_EXCERPT_LENGTH] + '...'
  end

  def add_author(author_id)
    self.author_id = author_id
  end
end