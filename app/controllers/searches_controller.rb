class SearchesController < ApplicationController
  def index
    @query = params[:query]

    if @query.length > 0
      query = "%#{@query.upcase}%"
      @subs = Sub.where('UPPER(title) LIKE ? OR UPPER(description) LIKE ?', query, query)
      @users = User.where('UPPER(username) LIKE ?', query)
      @posts = Post.where('UPPER(title) LIKE ? OR UPPER(content) LIKE ?', query, query)
      render :index
    else
      flash[:error] = 'Please enter a search term first'
      redirect_to request.referrer
    end
  end
end