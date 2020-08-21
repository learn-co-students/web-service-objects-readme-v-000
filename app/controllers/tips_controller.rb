class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.new_tip(session[:token], session[:venue_id], session[:tip])

    redirect_to tips_path
  end
end
