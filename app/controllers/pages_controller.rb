class PagesController < ApplicationController
  def index
    if current_user && !current_user.subscriptions.count.zero?
      subs_posts = current_user.subscribed_subs.includes(posts: [:votes, :author, :subs])
      posts = subs_posts.map { |sub| sub.posts }.flatten
      @posts = posts.sort_by { |post| post.created_at }.reverse[0...20]
    else
      @posts = Post.all.create_order(:desc).includes(:votes, :author, :subs).limit(20)
    end
    render :index
  end
end