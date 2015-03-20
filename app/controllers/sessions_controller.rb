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
      flash[:danger] = "Email或者密码不匹配，请重新输入"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end