class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.listTips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    foursquare.addTip(params[:venue_id], params[:tip], session[:token])

    redirect_to tips_path
  end
end
