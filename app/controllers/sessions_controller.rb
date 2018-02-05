class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    foursquare = FoursquareService.new
    session[:token] = foursquare.authenticate!(ENV['FOURSQUARE_ID'],ENV['FOURSQUARE_SECRET'], PARAMS[:code])
    redirect_to root_path
  end
end
