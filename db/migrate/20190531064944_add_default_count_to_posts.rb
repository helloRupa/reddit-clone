class AddDefaultCountToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :comments_count, :integer, default: 0

    Post.all.each do |post|
      post.comments_count = post.comments.count
      post.save
    end
  end
end
