class SearchesController < ApplicationController

  def search
  end

  def friends
    req = FoursquareService.new
    @friends = req.friends(session[:token])
  end

  def foursquare
    req = FoursquareService.new
    
    @venues = req.foursquare(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])
    
    render 'search'
  end
end
