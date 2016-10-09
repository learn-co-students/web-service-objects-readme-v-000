class SearchesController < ApplicationController

  def search
  end

 def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = "GBRL4N4CBDUDLJHGJMRAB3E3US1L1T1O3OK3UXT5MWVHDOYI"
    client_secret = "UVT0FBTBO5YM144NXTGJMJJ3YJHWFNGZKTX0GZQW1QOKWBQQ"

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

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
