class FoursquareService
  def authenticate(client_id, client_secret, code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
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

  def auth_user(client_id)
    client_id = client_id
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
  end

  def tips(token)
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def new_tip(token, venue_id, tip)
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
      req.params['venueId'] = venue_id
      req.params['text'] = tip
    end
  end

  def search_foursquare(client_id, client_secret, zipcode)
    resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = zipcode
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(resp.body)

    if resp.success?
      body["response"]["venues"]
    else
      body["meta"]["errorDetail"]
    end
  end
end
