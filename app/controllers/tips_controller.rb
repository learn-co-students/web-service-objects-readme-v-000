class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @tips = foursquare.tipsList(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.createTip(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
