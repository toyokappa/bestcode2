class Users::ContractsController < Users::ApplicationController
  def create
    course = Course.find(params[:course_id])
    # NOTE: とりあえず契約中ステータスで契約を作成する
    current_user.mentee_contracts.create!(course: course, state: :under_contract)
    redirect_to plan_path(course.plan), success: "契約しました"
  end

  def destroy
    course = Course.find(params[:course_id])
    # NOTE: 作成日時の新しい契約 = 活きた契約である前提での実装
    contract = current_user.mentee_contracts.order(created_at: :desc).find_by!(course: course)
    contract.state_finished!
    redirect_to plan_path(course.plan), success: "解約しました"
  end
end
