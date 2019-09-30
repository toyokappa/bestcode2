class Users::MenteesController < Users::ApplicationController
  def index
    @mentees = current_user.mentees.with_alive_contracts
  end
end
