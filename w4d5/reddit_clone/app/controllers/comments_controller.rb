class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    # fail
    if @comment.save
      # fail
      redirect_to send("#{@comment.commentable_type.downcase}_url", "#{@comment.commentable_id}")
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to :back
    end

  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(
      :content,
      :commentable_type,
      :commentable_id,
      :parent_comment_id
    )
  end
end
