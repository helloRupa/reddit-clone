class RenameAuthorInComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :author, :author_id
  end
end
