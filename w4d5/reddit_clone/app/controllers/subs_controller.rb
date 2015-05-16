class SubsController < ApplicationController
  before_action :require_moderator!, only: [:edit, :update]

  def new
    @sub = Sub.new

  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index

  end


  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_moderator!
    @sub = Sub.find(params[:id])
    redirect_to users_url unless current_user == @sub.moderator
  end

end
