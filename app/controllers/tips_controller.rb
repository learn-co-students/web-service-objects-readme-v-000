class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.allTips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    newTip = foursquare.makeTip(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
