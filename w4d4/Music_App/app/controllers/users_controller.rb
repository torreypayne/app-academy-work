class UsersController < ApplicationController


  def create
    new_user = User.new(user_params)
    if new_user.save
      flash[:notice] = "Success!"
      log_in_user!(new_user)
      redirect_to user_url(new_user)
    else
      flash.now[:errors] = new_user.errors.full_messages
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def new
    new_user = User.new
  end

  def show
  end

  def index
    render json: User.all
  end
end
