class UsersController < ApplicationController
  before_filter :require_current_user, only: [:show]

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @goal = @user.goals.new
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
