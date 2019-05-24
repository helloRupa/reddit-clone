class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to new_session_url
  end

  def already_logged_in
    return unless logged_in?
    redirect_to user_url(current_user)
  end

  def not_logged_in
    return if logged_in?
    redirect_to new_session_url
  end
end
