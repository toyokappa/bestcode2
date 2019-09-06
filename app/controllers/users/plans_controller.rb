class Users::PlansController < Users::ApplicationController
  def new
    plan = current_user.plans.build
    plan.spots.build
    @form = PlanForm.new(plan)
  end

  def create
    plan = current_user.plans.build
    plan.spots.build
    @form = PlanForm.new(plan)
    if @form.validate(plan_params)
      @form.save
      redirect_to plan, success: "プランを作成しました"
    else
      render :new
    end
  end

  def edit
    @plan = current_user.plans.find(params[:id])
    @form = PlanForm.new(@plan)
  end

  def update
    @plan = current_user.plans.find(params[:id])
    @form = PlanForm.new(@plan)
    if @form.validate(plan_params)
      @form.save
      redirect_to @plan, success: "プランを更新しました"
    else
      render :edit
    end
  end

  def destroy
    plan = current_user.plans.find(params[:id])
    plan.destroy!
    redirect_to root_path, success: "プランを削除しました"
  end

  private

    def plan_params
      params.require(:plan).permit(:name, :description, :state, spots_attributes: [:id, :name, :description])
    end
end
