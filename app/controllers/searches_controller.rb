class SearchesController < ApplicationController
  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare_hi = FoursquareService.new
    @venues = foursquare_hi.foursquare(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
    render 'search'
  end
end
