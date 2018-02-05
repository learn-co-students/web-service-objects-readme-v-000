class TipsController < ApplicationController
  def index
    foursquare = Foursquare.new
    @results = foursquare.tips(session[:token])
  end

  def create
    foursquare = Foursquare.new
    foursquare.create_tip(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
