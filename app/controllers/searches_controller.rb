class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare_service = FoursquareService.new
    @friends = foursquare_service.friends(session[:token])
  end

  def foursquare
    foursquare_service = FoursquareService.new
    resp, body = foursquare_service.search(session[:token], params[:zipcode])
    if resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
