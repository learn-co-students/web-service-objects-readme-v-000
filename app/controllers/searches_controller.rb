class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = Foursquare.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = ENV["CLIENT_ID"]
    client_secret = ENV["CLIENT_SECRET"]

    foursquare = Foursquare.new

    @resp = foursquare.foursquare(client_id,client_secret, params[:zipcode])
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
