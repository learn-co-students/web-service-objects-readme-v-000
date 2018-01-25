class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def venue_list
    foursquare = FoursquareService.new
    @resp = foursquare.venues(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_CLIENT_SECRET'], params[:zipcode])

    if @resp["meta"]["code"] == 200
      binding.pry
      @venues = @resp["response"]["venues"]
    else
      @error = @resp["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
