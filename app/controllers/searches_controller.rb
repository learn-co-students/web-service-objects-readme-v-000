class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
    @venues = foursquare.venues(client_id, client_secret, params[:zipcode])
    render 'search'
  end
end
