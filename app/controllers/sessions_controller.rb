class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  ## moved to app/services/foursquare_service.rb

  # def create
  #   resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
  #     req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
  #     req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
  #     req.params['grant_type'] = 'authorization_code'
  #     req.params['redirect_uri'] = "http://localhost:3000/auth"
  #     req.params['code'] = params[:code]
  #   end
  #
  #   body = JSON.parse(resp.body)
  #   session[:token] = body["access_token"]
  #   redirect_to root_path
  # end

  # Instantiate a new FoursquareService object and call our #authenticate! method!


#clean up OAuth flow 
  def create
    foursquare = FoursquareService.new
    # FoursquareService that can provide an OAuth token
    # pass in the client ID and secret via our .env environment variables, not the responsibility of the controller to know the internals of the Foursquare API, it's not the responsibility of the Foursquare service to know where to go to get system data.

    session[:token] = foursquare.authenticate!(
      ENV['FOURSQUARE_CLIENT_ID'],
      ENV['FOURSQUARE_SECRET'],
      params[:code]
    )
    redirect_to root_path
  end
end
