class SearchesController < ApplicationController
  def search; end

  def friends
    foursquares = FoursquareService.new
    @friends = foursquares.friends(session[:token])
  end

  def foursquare
    foursquares = FoursquareService.new
    @friends = foursquares.friends(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
  end
end
