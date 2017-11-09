class FoursquareService
  def authenticate!(client_id, client_secret, code)
    response = Faraday.get('https://foursquare.com/oauth2/access_token') do |request|
      request.params['client_id'] = client_id
      request.params['client_secret'] = client_secret
      request.params['grant_type'] = 'authorization_code'
      request.params['redirect_uri'] = 'http://localhost:3000/auth'
      request.params['code'] = code
    end
    body =  JSON.parse(response.body)
    body["access_token"]
  end

  def friends
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
  end

end
