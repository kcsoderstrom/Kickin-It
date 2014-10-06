class CommentsController < ApplicationController
  def index
    set_commentable
    render :index
  end

  def create
    set_commentable
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to action_url
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :index
    end
  end

  def destroy
  end

  private
  def set_commentable
    if params[:goal_id]
      @commentable = Goal.find(params[:goal_id])
    elsif params[:user_id]
      @commentable = User.find(params[:user_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def action_url
    if @commentable.class == User
      user_comments_url(@commentable)
    elsif @commentable.class == Goal
      goal_comments_url(@commentable)
    end
  end
end
