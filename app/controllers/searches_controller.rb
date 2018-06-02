class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FourSquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
  foursquare = FourSquareService.new
  venues = foursquare.coffee_shop(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
  venues.success? ? @venues = body["response"]["venues"] : @error = body["meta"]["errorDetail"]
  render 'search'
  end

end
