class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      if user.today_planning
        redirect_to planning_path(user.today_planning)
      else
        redirect_to new_planning_path
      end
    else
      render :new
    end
  end
end