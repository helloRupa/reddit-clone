class PagesController < ApplicationController
  def index
    @posts = Post.all.create_order(:desc).includes(:votes, :author).limit(20)
    render :index
  end
end