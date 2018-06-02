class SessionsController < ApplicationController
 skip_before_action :authenticate_user, :only => :create
 
  def create
    foursquare = FoursquareService.new
    session[:token] = foursquare.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
    redirect_to root_path
  end

end
