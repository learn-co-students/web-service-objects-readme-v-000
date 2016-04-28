class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare_object = FoursquareService.new
    @friends = foursquare_object.friends(session[:token])
  end

  def foursquare
    foursquare_object = FoursquareService.new
    resp = foursquare_object.venues(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], params[:zipcode])
    if resp.is_a?(String)
      @error = resp
    else
      @venues = resp
    end
      render 'search'
  end

end
