class WelcomeController < ApplicationController
  def index
    @plans = Plan.all
  end
end
