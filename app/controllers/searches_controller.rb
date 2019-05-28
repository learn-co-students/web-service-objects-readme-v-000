class SearchesController < ApplicationController

  def search
  end

  def friends
    @friends = FoursquareService.new.friends(session[:token])
  end

  def foursquare
    resp = FoursquareService.new.venues(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
    resp[:venues] ? @venues = resp[:venues] : @error = resp[:error]
    render 'search'
  end
end
