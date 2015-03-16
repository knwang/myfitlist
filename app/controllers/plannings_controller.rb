class PlanningsController < ApplicationController
  def show
    # @planning = Planning.find_by(created_at: "2015-03-10 01:06:05")
    @planning = Planning.find(params[:id])
  end
end