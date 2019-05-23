class UsersController < ApplicationController
  before_action :not_logged_in, only: [:show, :destroy]
  before_action :already_logged_in, only: [:new, :create, :activate]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @url = activate_users_url(activation_token: @user.activation_token)
      render :activate
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_username(params[:username])
    render :show
  end

  def destroy
    user = current_user

    if user.destroy
      redirect_to new_user_url
    else
      flash[:error] = 'Oops, something went wrong and you still exist'
      redirect_to user_url(user)
    end
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token])

    if user
      handle_activation(user)
      redirect_to new_session_url
    else
      flash[:error] = 'User not found. Please register first'
      redirect_to new_user_url
    end
  end

  private

  def handle_activation(user)
    if user.activated
      flash[:notice] = 'This account is already active'
    else
      flash[:notice] = 'You have successfully activated your account'
      user.activate_user
    end
  end

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end