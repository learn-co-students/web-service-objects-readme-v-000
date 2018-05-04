class SearchesController < ApplicationController

  def search
  end

  def friends

    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
   
  end

  def foursquare

    foursquare = FoursquareService.new
    @search = foursquare.venues(params[:zipcode])
    
    if @search[0]["id"]
      @venues = @search   
    else
      @error = @search  
    end  

    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'

  end

end
