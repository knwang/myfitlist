class PagesController < ApplicationController
  def front
    if signed_in?
      show_user_today_planning(current_user)
    else
      render :front
    end
  end
end