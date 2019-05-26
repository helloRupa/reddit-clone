class Comment < ApplicationRecord
  include Ordering

  validates :content, presence: true

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author_id

  belongs_to :post

end