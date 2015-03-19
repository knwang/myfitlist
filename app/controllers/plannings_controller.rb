class PlanningsController < ApplicationController
  before_action :set_planning, only: [:show, :update]

  def new
    @planning = Planning.new
  end

  def create
    current_user = User.find(session[:user_id]) if session && session[:user_id]
    @planning = Planning.new(planning_params)
    @planning.user_id = current_user.id

    if @planning.save
      redirect_to planning_path(@planning)
    else
      render :new
    end
  end

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