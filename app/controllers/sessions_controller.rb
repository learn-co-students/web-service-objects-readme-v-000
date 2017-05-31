class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    foursquare = Foursquare.new
    redirect_to root_path
  end
end
