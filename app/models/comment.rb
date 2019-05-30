class Comment < ApplicationRecord
  include Ordering
  include Calcs
  include Voteable

  QUOTE_LENGTH = 72

  validates :content, presence: true

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author_id

  belongs_to :post

  belongs_to :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id,
    optional: true

  has_many :child_comments,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id

  def quote
    self.content.length <= QUOTE_LENGTH ? self.content : "#{self.content[0..QUOTE_LENGTH]}..."
  end

  def destroy
    self.author_id = User.find_by_username(DESTROYED).id
    self.content = 'comment deleted'
    self.save!
  end
end