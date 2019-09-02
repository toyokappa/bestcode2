class Users::SessionsController < Users::ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_by_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path, success: "ログインしました"
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, success: "ログアウトしました"
  end
end
