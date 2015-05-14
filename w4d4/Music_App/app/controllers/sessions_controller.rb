class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_credentials(user_params)
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash[:errors] << user.errors.full_messages
      render :new
    end
  end

end
