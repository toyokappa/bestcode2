class Users::PlansController < ApplicationController
  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to root_path, success: "プランを作成しました"
    else
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :description, :state)
  end
end
