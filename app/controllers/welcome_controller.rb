class WelcomeController < ApplicationController
  def index
    @plans = Plan.all.includes(:user, :courses)
  end
end
