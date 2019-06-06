class CommentsController < ApplicationController
  before_action :not_logged_in, except: [:show]
  before_action :wrong_user, only: [:destroy]
  
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(author_id: current_user.id)

    if @comment.update_attributes(comment_params)
      redirect_to post_url(Post.find_by_id(@comment.post_id), show_cid: "c-#{@comment.id}")
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end

  def show
    comment_data = Comment.where(id: params[:id]).includes(:author, parent_comment: :author)
    @comment = comment_data.first
    @parent_comment = @comment.parent_comment
    post_data = Post.where(id: @comment.post_id).includes(:author, comments: [:author, :votes]).create_order
    @post = post_data.first
    @post_author = @post.author
    render :show
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    flash[:error] = comment.errors.full_messages unless comment.overwrite
    redirect_to request.referrer
  end

  def upvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Comment', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.upvote!
    redirect_to "#{request.referrer}?show_cid=c-#{params[:id]}#c-#{params[:id]}"
  end

  def downvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Comment', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.downvote!
    redirect_to "#{request.referrer}?show_cid=c-#{params[:id]}#c-#{params[:id]}"
  end

  private

  def wrong_user
    comment = Comment.find_by_id(params[:id])
    moderators = comment.post.moderators.pluck(:id)
    moderators << current_user.id
    return if moderators.include?(current_user.id)
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end
end
