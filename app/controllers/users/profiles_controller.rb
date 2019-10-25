class Users::ProfilesController < Users::ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path(current_user), success: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

    def user_params # rubocop:disable Metrics/MethodLength
      params.require(:user).permit(
        :display_name,
        :image,
        :image_cache,
        :introduction,
        :url,
        resumes_attributes: [
          :id,
          :description,
          :start_year,
          :start_month,
          :end_year,
          :end_month,
          :_destroy,
        ],
        skills_attributes: [
          :id,
          :name,
          :level,
          :experience,
          :_destroy,
        ],
      )
    end
end
