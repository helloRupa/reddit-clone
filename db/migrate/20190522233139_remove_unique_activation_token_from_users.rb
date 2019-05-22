class RemoveUniqueActivationTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :activation_token
    add_index :users, :activation_token
  end
end
