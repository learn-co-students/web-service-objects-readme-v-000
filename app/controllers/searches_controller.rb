class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
    resp = foursquare.coffee_shops(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
    venues = JSON.parse(resp.body)
    resp.success? ? @venues = venues["response"]["venues"] : @error = venues["meta"]["errorDetail"]
    render 'search'
  end
end
