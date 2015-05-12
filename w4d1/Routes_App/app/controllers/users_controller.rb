class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    new_username = params[:user][:username]
    user.username = new_username
    my_render(user)
  end

  def create
    user = User.new(user_params)
    my_render(user)
  end

  def destroy
    username = User.find(params[:id]).username
    User.destroy(params[:id])
    render text: "deleted user #{username}"
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def my_render(user)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
end
