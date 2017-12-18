class FoursquareService
  def authenticate!(client_id, client_secret, code)
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
end


def venue_searches(client_id, client_secret, zipcode)
  venues, error = nil
  resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = client_id
    req.params['client_secret'] = client_secret
    req.params['v'] = '20160201'
    req.params['near'] = zipcode
    req.params['query'] = 'coffee shop'
  end

  body = JSON.parse(resp.body)

  if resp.success?
    venues = body["response"]["venues"]
  else
    error = body["meta"]["errorDetail"]
  end

  return venues, error

  rescue Faraday::TimeoutError
    error = "There was a timeout. Please try again."
    return venues, error
  end

  def tips(token)
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    return JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def create_tips(token, venue_id, tip_text)
  end
end
