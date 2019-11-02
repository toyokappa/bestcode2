class PlansController < ApplicationController
  def index
    @plans = Plan.search(params[:keyword]).includes(:user, :courses)
  end

  def show
    @plan = Plan.find(params[:id])
    @courses = @plan.courses.where(has_stopped: false)
  end
end
