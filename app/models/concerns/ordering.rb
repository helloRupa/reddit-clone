module Ordering
  extend ActiveSupport::Concern
  
  module ClassMethods
    def create_order(ord = :asc)
      self.order(created_at: ord)
    end

    def update_order(ord = :asc)
      self.order(updated_at: ord)
    end

    def alpha_order(col, ord = :asc)
      ord == :asc ? self.order(self.arel_table[col].lower.asc) : self.order(self.arel_table[col].lower.desc)
    end
  end
end