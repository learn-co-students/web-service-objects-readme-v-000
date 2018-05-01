class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @tips = foursquare.tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.create_tip(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
