class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    foursquare = FoursquareService.new
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
