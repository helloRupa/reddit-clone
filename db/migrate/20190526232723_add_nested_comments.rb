class AddNestedComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_column_id, :integer
    add_index :comments, :parent_column_id
  end
end
