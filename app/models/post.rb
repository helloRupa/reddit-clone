# title       string        required
# url         text
# content     text
# sub_id      integer       required
# author_id   integer       required

class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: MIN_POST, maximum: MAX_POST }

  belongs_to :sub

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author_id
end