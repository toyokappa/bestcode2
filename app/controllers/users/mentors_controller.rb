class Users::MentorsController < Users::ApplicationController
  def index
    @mentors = current_user.mentors.with_alive_contracts(user_type: :mentor).includes(:contracted_courses)
  end
end
