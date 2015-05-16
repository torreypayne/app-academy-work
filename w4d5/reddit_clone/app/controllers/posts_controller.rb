class PostsController < ApplicationController

  before_action :require_author!, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      render :show
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render :show
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url, :sub_ids => [])
  end

  def require_author!
    @post = Post.find(params[:id])
    redirect_to users_url unless current_user == @post.author
  end

end
