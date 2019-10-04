class Users::ProfilesController < Users::ApplicationController
  def edit
  end

  def update
    if current_user.update(user_paramas)
      redirect_to profile_path(current_user.name), success: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

    def user_paramas
      params.require(:user).permit(:display_name, :image, :image_cache)
    end
end
