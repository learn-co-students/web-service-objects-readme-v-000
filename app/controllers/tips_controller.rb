class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.create_tips(session[:token], params[:venueId], params[:tips])

    redirect_to tips_path
  end
end
