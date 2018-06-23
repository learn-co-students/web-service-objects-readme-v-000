class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquare = FoursquareService.new
    @resp = foursquare.foursquare(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], params[:zipcode])
    if @resp["response"]
      @venues = @resp["response"]["venues"]
    else
      @error = @resp
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
