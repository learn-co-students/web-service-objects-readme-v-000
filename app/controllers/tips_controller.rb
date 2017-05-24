class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.getTips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.addTip(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end

end
