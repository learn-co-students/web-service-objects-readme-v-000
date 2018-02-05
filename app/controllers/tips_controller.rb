class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    resp = foursquare.tips_create(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
