module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes,
      as: :voteable
  end

  def vote_total
    self.votes.pluck(:value).sum
  end
end