class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    foursquareservice = FoursquareService.new
    @venues, @error = foursquareservice.search(params[:zipcode], 'coffee shop')

    render 'search'
  end
end
