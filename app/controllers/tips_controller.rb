class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tipIndex(session[:token])["response"]["list"]["listItems"]["items"]
  end

  def create
    foursquare = FoursquareService.new
    foursquare.tipCreate(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
