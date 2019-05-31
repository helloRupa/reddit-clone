class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :sub_id], unique: true
  end
end
