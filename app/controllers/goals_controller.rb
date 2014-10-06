class GoalsController < ApplicationController
  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = current_user
      render "users/show"
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content)
  end

end
