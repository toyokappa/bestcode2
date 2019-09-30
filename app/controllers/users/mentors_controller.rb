class Users::MentorsController < Users::ApplicationController
  def index
    @mentors = current_user.mentors.with_alive_contracts(user_type: :mentor).includes(:own_courses)
  end
end
