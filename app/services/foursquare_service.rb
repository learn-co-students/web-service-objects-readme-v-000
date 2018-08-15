class FoursquareService


  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://67.205.182.198:55372/auth"
      req.params['code'] = code
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

end
