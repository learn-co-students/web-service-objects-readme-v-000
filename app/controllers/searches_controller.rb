class SearchesController < ApplicationController

  def search
    
  end


  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
    @venues = foursquare.foursquare_venues(session[:token], params[:zipcode])
    
    render 'search'
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
