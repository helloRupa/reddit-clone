class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end

    add_index :post_subs, [:sub_id, :post_id], unique: true
    add_index :post_subs, :post_id

    Post.all.each do |p|
      PostSub.create!(post_id: p.id, sub_id: p.sub_id)
    end
  end
end
