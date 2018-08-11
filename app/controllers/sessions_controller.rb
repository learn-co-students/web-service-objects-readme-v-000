class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    fs = FoursquareService.new
    session[:token] = fs.authenticate!(ENV['FOURSQUARE_CLIENT'], ENV['FOURSQUARE_SECRET'], params[:code])
    redirect_to root_path
  end

end
