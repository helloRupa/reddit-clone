class AddSlugToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :slug, :string
    Post.all.each do |p|
      p.update_attributes(slug: p.title.parameterize)
    end
    change_column_null :posts, :slug, false
  end
end
