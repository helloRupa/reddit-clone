class PostsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create, :upvote, :downvote]
  before_action :wrong_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post_subs = []
    @subs = Sub.alpha_order(:title).select(:id, :title)
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.add_author(current_user.id)

    if @post.save
      redirect_to post_url(@post)
    else
      @post_subs = params[:post][:sub_ids][1..-1].map(&:to_i)
      @subs = Sub.alpha_order(:title).select(:id, :title)
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def show
    post_data = Post.where(id: params[:id]).includes(comments: [:author, :votes]).create_order
    @post = post_data.first
    @moderators = @post.moderators.pluck(:id)
    @comments = @post.comments
    @author = @post.author
    @subs = @post.subs.alpha_order(:title).select(:id, :title)
    render :show
  end

  def edit
    @post = Post.find_by_id(params[:id])
    @post_subs = @post.subs.pluck(:id)
    @subs = Sub.alpha_order(:title).select(:id, :title)
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      @post_subs = @post.subs.pluck(:id)
      @subs = Sub.alpha_order(:title).select(:id, :title)
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.destroy
      redirect_to root_url
    else
      flash[:error] = "Oops, something went wrong. Post still exists."
      render :show
    end
  end

  def upvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Post', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.upvote!
    redirect_to "#{request.referrer}#p-#{params[:id].to_i}"
  end

  def downvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Post', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.downvote!
    redirect_to "#{request.referrer}#p-#{params[:id].to_i}"
  end

  private

  def wrong_user
    post = Post.find_by_id(params[:id])
    return if post.author == current_user || post.moderators.include?(current_user)
    redirect_to post_url(post)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end