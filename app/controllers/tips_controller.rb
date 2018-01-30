class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.all_tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    @tip = foursquare.tip(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
