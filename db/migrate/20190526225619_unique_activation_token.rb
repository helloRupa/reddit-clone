class UniqueActivationToken < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :activation_token
    add_index :users, :activation_token, unique: true
  end
end
