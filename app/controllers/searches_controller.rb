class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
        @venues, @errors = foursquare.venues(
          ENV['FOURSQUARE_CLIENT_ID'],
          ENV['FOURSQUARE_SECRET'],
          params[:zipcode],
          'coffee shop'
        )

        render 'search'
  end
end
