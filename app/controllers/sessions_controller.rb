class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    foursquare = FoursquareService.new
    session[:token] = foursquare.authenticate!(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], params[:code])
    redirect_to root_path
  end
end
