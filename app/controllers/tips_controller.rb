class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.getTips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.submitTip(session[:token], params[:venue_id], params[:tip])
  end
end
