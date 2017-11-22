class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
    resp = foursquare.venues_search(
      ENV['FOURSQUARE_CLIENT_ID'],
      ENV['FOURSQUARE_SECRET'],
      params[:zipcode]
    )

    @venues = resp.venues
    @error = resp.errors

    render 'search'
  end

end
