class ProfilesController < ApplicationController
  def show
    @user = User.find_by!(name: params[:user_name])
  end
end
