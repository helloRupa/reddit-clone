class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :url
      t.text :content
      t.integer :sub_id, null: false
      t.integer :author_id, null: false
    end

    add_index :posts, :sub_id
    add_index :posts, :author_id
    add_index :posts, :title
  end
end
