class FoursquareService

  def authenticate!(code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
    end

    body = JSON.parse(resp.body)["access_token"]
  end

  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      # don't forget that pesky v param for versioning
      req.params['v'] = ENV['FOURSQUARE_V']
    end

    JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  def search(near, query)
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['v'] = ENV['FOURSQUARE_V']
      req.params['near'] = near
      req.params['query'] = query
      req.options.timeout = 10
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
      return [@venues, nil]
    else
      @error = body["meta"]["errorDetail"]
      return [nil, @error]
    end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      return [nil, @error]
  end

end
