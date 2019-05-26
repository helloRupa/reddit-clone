class CommentsController < ApplicationController
  before_action :not_logged_in
  
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(author_id: current_user.id, post_id: params[:post_id])

    if @comment.update_attributes(comment_params)
      redirect_to request.referrer
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
