class SearchesController < ApplicationController

  def search
  end

  def friends
    # resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
    #   req.params['oauth_token'] = session[:token]
    #   # don't forget that pesky v param for versioning
    #   req.params['v'] = '20160201'
    # end
    # @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare

    foursquare = FoursquareService.new
    @resp = foursquare(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode])

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
