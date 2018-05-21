class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
     foursquare = FoursquareService.new
     @resp = foursquare.coffee_shops(params[:zipcode])
         body = JSON.parse(@resp.body)

         if @resp.success?
           @venues = body["response"]["venues"]
         else
           @error = body["meta"]["errorDetail"]
         end
         render 'search'
      end

end
