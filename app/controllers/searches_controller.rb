class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end
 
	def foursquare
		foursquare = FoursquareService.new
		results = foursquare.coffee_shop(session[:token], params[:zipcode])
		@venues = results[0]
		@error = results[1]
		
		render 'search'
	end
end
