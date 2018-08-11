class SearchesController < ApplicationController

  def search
  end

  def friends
    fs = FoursquareService.new
    @friends = fs.friends(session[:token])
  end

  def foursquare
    fs = FoursquareService.new
    result = fs.coffee_shop(ENV['FOURSQUARE_CLIENT'], ENV['FOURSQUARE_SECRET'], params[:zipcode])

    if result.type = "success"
      @venues = result.content
    elsif result.type = "error"
      @error = result.content
    end
    render 'search'
  end

end
