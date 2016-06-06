class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tips(params[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.create_tip(params[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
