class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
