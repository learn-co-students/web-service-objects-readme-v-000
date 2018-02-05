class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursq = FoursquareService.new
    resp = foursq.foursquare(params[:zipcode], ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'])
    if resp.is_a?(Array)
      @venues = resp
    else
      @error = resp
    end
    render 'search'

  end
end
