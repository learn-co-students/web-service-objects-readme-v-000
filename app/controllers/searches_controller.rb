class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = FOURQUARE_CLIENT_ID
    client_secret = FOURSQUARE_SECRET
    foursquare = FoursquareService.new
    @foursquare = foursquare(ENV['FOURQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
  end
end
