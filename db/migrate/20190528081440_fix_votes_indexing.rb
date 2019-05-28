class FixVotesIndexing < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, [:user_id, :voteable_type]
    add_index :votes, [:user_id, :voteable_type, :voteable_id], unique: true
  end
end
