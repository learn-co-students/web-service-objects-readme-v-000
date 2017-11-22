class SearchesController < ApplicationController

    def search
    end

    def friends
        foursquare = FoursquareService.new
        @friends = foursquare.friends(session[:token])
    end

    def foursquare
        client_id = ENV['FOURSQUARE_CLIENT_ID']
        client_secret = ENV['FOURSQUARE_SECRET']
        begin
            foursquare = FoursquareService.new
            resp = foursquare.find_coffee_shop(client_id, client_secret, params[:zipcode])
            
            @venues = resp[:venues]
            @error = resp[:error]

        rescue Faraday::TimeoutError
            @error = "There was a timeout. Please try again."
        end

        render 'search'
    end
end