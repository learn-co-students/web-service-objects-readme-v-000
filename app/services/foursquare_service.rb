class FoursquareService

  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get('https://foursquare.com/oauth/access_token') do |req|
      req.params["client_id"] = client_id
      req.params["client_secret"] = client_secret
      req.params["code"] = code
      req.params["grant_type"] = "authorization_code"
      req.params["redirect_uri"]= "http://localhost:3000/auth"
    end
    body = JSON.parse(resp.body)
    body["access_token"]
  end

  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  def foursquareVenue(client_id, client_secret, zipcode)
    resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
        req.params['v'] = '20160201'
        req.params['near'] = zipcode
        req.params['query'] = 'coffee shop'
      end
      @resp = JSON.parse(resp.body)
  end

  def tipIndex(token)
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)
  end

  def tipCreate(token, venue_id, tip)
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
      req.params['venueId'] = venue_id
      req.params['text'] = tip
    end
    JSON.parse(resp.body)
  end 

end
