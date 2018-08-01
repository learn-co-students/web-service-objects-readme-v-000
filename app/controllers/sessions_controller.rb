class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    #create a new service object instance as 'foursquare'
    foursquare=FoursquareService.new
    
    #use authenticate! to grab the token based on the 'code' supplied to the callback function and our creds
    session[:token]=foursquare.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'],params[:code])
    
    #send em on their way
    redirect_to root_path
    
    
    #all our Foursquare service object does is get the authentication token, so that's all we ask it to do.
  end
    

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
