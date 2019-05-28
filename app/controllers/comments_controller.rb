class CommentsController < ApplicationController
  before_action :not_logged_in
  
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(author_id: current_user.id)

    if @comment.update_attributes(comment_params)
      redirect_to request.referrer
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end

  def upvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Comment', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.upvote!
    redirect_to "#{request.referrer}#c-#{params[:id]}"
  end

  def downvote
    vote = Vote.new(user_id: current_user.id, voteable_type: 'Comment', voteable_id: params[:id].to_i)
    flash[:error] = vote.errors.full_messages unless vote.downvote!
    redirect_to "#{request.referrer}#c-#{params[:id]}"
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end
end
