class RenameParentColumnId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :parent_column_id, :parent_comment_id
  end
end
