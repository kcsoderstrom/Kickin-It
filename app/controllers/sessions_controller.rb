class SessionsController < ApplicationController
  def new

  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
