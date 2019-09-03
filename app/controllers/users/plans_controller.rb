class Users::PlansController < Users::ApplicationController
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

  def edit
    @plan = current_user.plans.find(params[:id])
  end

  def update
    @plan = current_user.plans.find(params[:id])
    if @plan.update(plan_params)
      redirect_to root_path, success: "プランを更新しました"
    else
      render :edit
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :description, :state)
  end
end
