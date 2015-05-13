class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def already_logged_in
    redirect_to cats_url if current_user
  end

  def owns_cat
    redirect_to cats_url unless cat.owner == current_user
  end
end
