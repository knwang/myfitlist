class PlanningsController < ApplicationController
  before_action :set_planning
  
  def show
    @planning = Planning.find(params[:id])
  end

  def update
    if @planning.update(planning_params)
      redirect_to planning_path(@planning)
    else
      render :show
    end
  end

  private

  def set_planning
    @planning = Planning.find(params[:id])
  end

  def planning_params
    params.require(:planning).permit(:weight)
  end
end