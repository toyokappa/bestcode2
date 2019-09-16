class Users::PlansController < Users::ApplicationController
  def new
    plan = current_user.build_plan
    plan.courses.build
    @form = PlanForm.new(plan)
  end

  def create
    plan = current_user.build_plan
    plan.courses.build
    @form = PlanForm.new(plan)
    if @form.validate(plan_params)
      @form.save
      redirect_to plan, success: "プランを作成しました"
    else
      render :new
    end
  end

  def edit
    @plan = current_user.plan
    @form = PlanForm.new(@plan)
  end

  def update
    @plan = current_user.plan
    @form = PlanForm.new(@plan)
    if @form.validate(plan_params)
      @form.save
      redirect_to @plan, success: "プランを更新しました"
    else
      render :edit
    end
  end

  def destroy
    current_user.plan.destroy!
    redirect_to root_path, success: "プランを削除しました"
  end

  private

    def plan_params
      params.require(:plan).permit(:name, :description, :state, courses_attributes: [:id, :name, :description, :fee, :is_shot, :has_stopped])
    end
end
