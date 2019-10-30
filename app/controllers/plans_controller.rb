class PlansController < ApplicationController
  def index
    @plans = Plan.search(params[:keyword]).includes(:user, :courses)
  end

  def show
    @plan = Plan.find(params[:id])
  end
end
