class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
            #Create a new foursquare object and set it equal to a variable
    foursquare = FoursquareService.new
            #set the session token = to our variable with our services method called on it and the appropriate arguments (in this case the FOURSQUARE_CLIENT_ID and FOURSQUARE_SECRET) passed into the authenticate! method.
    session[:token] = foursquare.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'],
            #Where does this ':code' come from?
    params[:code])
            #redirect to the root path set in routes
    redirect_to root_path
  end
end
