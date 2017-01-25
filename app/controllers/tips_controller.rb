class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.index(session[:token])
  end

  def create(session[:token], params[:venue_id], params[:tip])
    foursquare = FoursquareService.new
    redirect_to tips_path
  end
end
