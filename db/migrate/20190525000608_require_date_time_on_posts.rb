class RequireDateTimeOnPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :created_at, false
    change_column_null :posts, :updated_at, false
  end
end
