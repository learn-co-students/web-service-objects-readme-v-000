class FoursquareService

  def authenticate!(client_id, client_secret, code)
    response = Faraday.get ("https://foursquare.com/outh2/access_tokent") do |request|
      request.params['client_id'] = client_id
      request.params['client_secret'] = client_secret
      request.params['grant_type'] = 'authorization_code'
      request.params['redirect_uri'] = "http://localhost:3000/auth"
      request.paramts['code'] = code
    end

    body = JSON.parse(response.body)
    body["access_token"]
  end

  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      # don't forget that pesky v param for versioning
      req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
  end
end
