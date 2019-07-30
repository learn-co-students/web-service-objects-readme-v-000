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
          #session[:token] = body["access_token"]
          body["access_token"]
          #redirect_to root_path
        end

    def friends(token)
        resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
            #Changed from:
            #req.params['oauth_token'] = session[:token]
            #Changed to:
            req.params['oauth_token'] = token
            # don't forget that pesky v param for versioning
            req.params['v'] = '20160201'
          end
          #Changed from:
          #@friends = JSON.parse(resp.body)["response"]["friends"]["items"]
          #Changed to:
          JSON.parse(resp.body)["response"]["friends"]["items"]
        end
end