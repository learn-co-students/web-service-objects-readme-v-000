class SearchesController < ApplicationController

  def search
  end

  def friends
    @friends = FoursquareService.new.friends(session[:token])
  end

  def foursquare
    @resp = FoursquareService.new.coffee_shops(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
    render 'search'
  end
end
