class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @tips = foursquare.view_tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.add_tip(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
