class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tip_index(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    session[:token] = foursquare.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
    redirect_to root_path
  end
end
