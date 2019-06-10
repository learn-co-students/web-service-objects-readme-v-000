class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

private

  def authenticate_user
    client_id = ENV['FOURSQUARE_CLIENT_ID']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    foursquare = FourSquareService.new 
    foursquare.authenticate!(client_id, redirect_uri)
    redirect_to foursquare_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
