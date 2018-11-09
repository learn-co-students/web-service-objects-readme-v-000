class SearchesController < ApplicationController

  def search
  end

  def friends
    @friends = FoursquareService.new.friends(session[:token])
  end

  def foursquare
    result = FoursquareService.new.foursquare(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_CLIENT_SECRET'], params[:zipcode])

    if response.successful?
      @venues = result["response"]["venues"]
    else
      @error = result["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
