class Users::ProfilesController < Users::ApplicationController
  def edit
    @form = UserForm.new(current_user)
  end

  def update
    @form = UserForm.new(current_user)
    if @form.validate(user_paramas)
      @form.save
      redirect_to profile_path(current_user), success: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

    def user_paramas
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
      )
    end
end
