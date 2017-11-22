class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
    redirect_to root_path
  end
end
