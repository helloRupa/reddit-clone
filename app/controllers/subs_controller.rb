class SubsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create]
  before_action :wrong_user, only: [:edit, :update]

  def index
    @subs = Sub.subs_alpha_order
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_new_params)
    @sub.add_moderator(current_user.id)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    sub_data = Sub.where(title: params[:title]).includes(posts: [:author])
    @sub = sub_data.first
    @moderator = @sub.user
    render :show
  end

  def edit
    @sub = Sub.find_by_title(params[:title])
    render :edit
  end

  def update
    @sub = Sub.find_by_title(params[:title])

    if @sub.update_attributes(sub_edit_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def wrong_user
    sub = Sub.find_by_title(params[:title])
    return if sub.user == current_user
    redirect_to sub_url(sub)
  end

  def sub_new_params
    params.require(:sub).permit(:title, :description)
  end

  def sub_edit_params
    params.require(:sub).permit(:description)
  end
end