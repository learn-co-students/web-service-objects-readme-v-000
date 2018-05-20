class SearchesController < ApplicationController
  def index
    render 'search'
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def search
    foursquare = FoursquareService.new
    results = foursquare.search(ENV['FOURSQUARE_CLIENT_ID'],
                                ENV['FOURSQUARE_SECRET'],
                                params[:zipcode],
                                params[:query])
    results[:error] ? @error = results[:error] : @venues = results[:venues]

    render 'search'
  end
end
