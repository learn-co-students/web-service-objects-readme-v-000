class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    fs = FoursquareService.new 
    session[:tokon] = fs.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
    redirect_to root_path
  end
end
