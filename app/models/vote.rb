class Vote < ApplicationRecord
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:voteable_type, :voteable_id], message: 'can only vote once!' }
  validates :value, inclusion: { in: [1, -1], message: 'must be 1 or -1' }

  belongs_to :voteable, polymorphic: true

  def upvote!
    self.value = 1
    self.save
  end

  def downvote!
    self.value = -1
    self.save
  end
end