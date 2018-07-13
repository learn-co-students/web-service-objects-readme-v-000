class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare

    foursquare = FoursquareService.new
    resp = foursquare.search_coffee(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
    

    if resp.class != String
      @venues = resp
    else
      @error = resp
    end
      render 'search'
  end
end
