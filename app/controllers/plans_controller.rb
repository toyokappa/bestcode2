class PlansController < ApplicationController
  def index
    @plans = Plan.search(params[:keyword])
  end

  def show
    @plan = Plan.find(params[:id])
  end
end
