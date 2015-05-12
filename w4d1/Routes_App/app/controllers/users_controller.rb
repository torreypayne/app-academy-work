class UsersController < ApplicationController
  def index
    render text: "I'm in the index action!"
  end

  def show
    render json: params["some_category"]
  end

  def update
    user = User.find(params[:id])
    new_email = params[:user][:email]
    new_name = params[:user][:name]
    user[:email] = new_email
    user.save!
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    User.destroy(params[:id])
    render text: "deleted user at #{params}"
  end

  private

  def user_params
    params[:user].permit(:name, :email)
  end
end
