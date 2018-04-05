class FoursquareService


  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://192.168.0.119:3000/auth"
      #req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    body["access_token"]
    
  end
end