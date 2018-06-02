class TipsController < ApplicationController
  def index
   foursquare = FourSquareService.new
   @results = foursquare.tip(session[:token])
  end

  def create
   foursquare = FourSquareService.new
   foursquare.new_tip(token, params[:venue_id], params[:tip])
   redirect_to tips_path
  end
end
