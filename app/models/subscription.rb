class Subscription < ApplicationRecord
  validates :user_id, :sub_id, presence: true
  validates :user_id, uniqueness: { scope: :sub_id, message: 'can only subscribe to a sub once' }

  belongs_to :user

  belongs_to :sub
end