class ItemsController < ApplicationController
  before_action :set_planning

  def new
    @item = Item.new
  end

  def create
    binding.pry
    item = @planning.items.build(item_params)

    if item.save
      redirect_to planning_path(@planning)
    else
      render :new
    end
  end

  def update
    item = Item.find(params[:id])

    if item.update(item_params)
      flash[:success] = "保存成功"
      redirect_to planning_path(@planning)
    else
      flash[:danger] = "健身项目信息有误，请更正"
      render "plannings/show"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.delete if !item.finished and item.planning_id == @planning.id
    redirect_to planning_path(@planning)
  end

  private

  def item_params
    params.require(:item).permit(:finished, :name, :duration, :result, :unit)
  end

  def set_planning
    @planning = Planning.find(params[:planning_id])
  end
end