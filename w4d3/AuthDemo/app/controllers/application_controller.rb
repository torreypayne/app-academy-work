class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # Remember ActionController defines session method and user method

  def current_user
    return nil if session[:user_id].nil?
    User.find_by(session_token: self.session[:session_token])
  end

  def log_in!(user)
    user.reset_session_token!
    # Force other clients to log out by regenerating token
    # 
    self.session[:session_token] = user.session_token
  end

  def log_out!
    session[:session_token] = nil
  end
end
