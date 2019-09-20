class Users::MentorsController < Users::ApplicationController
  def index
    @mentors = current_user.mentors
  end
end
