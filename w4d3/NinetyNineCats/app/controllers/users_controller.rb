class UsersController < ApplicationController
  before_action :already_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_credentials(user_params)
  end

  private

    def user_params
      params.require(:users).permit(:username, :password)
    end
end
