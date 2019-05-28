class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.references :voteable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :votes, [:user_id, :voteable_type], unique: true
  end
end
