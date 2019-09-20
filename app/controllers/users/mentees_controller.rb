class Users::MenteesController < Users::ApplicationController
  def index
    @mentees = current_user.mentees
  end
end
