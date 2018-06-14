class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create

    resp_body = FoursquareService.new.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
    session[:token] = resp_body["access_token"]
    redirect_to root_path
  end
end
