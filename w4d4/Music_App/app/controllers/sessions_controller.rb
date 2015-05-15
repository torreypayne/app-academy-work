class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_credentials(
    email: params[:session][:email],
    password: params[:session][:password]
    )
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Invalid login!"
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
