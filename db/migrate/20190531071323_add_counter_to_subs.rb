class AddCounterToSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :subscriptions_count, :integer, default: 0

    Sub.all.each { |s| Sub.reset_counters(s.id, :subscriptions) }
  end
end
