class AddValueToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :value, :integer, null: false
  end
end
