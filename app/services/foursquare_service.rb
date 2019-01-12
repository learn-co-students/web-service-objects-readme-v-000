class FoursquareService
=begin 
Step 1 in application_controller
  Step 2 - If the user accepts, they will be redirected back to your URI with a code.
    https://YOUR_REGISTERED_REDIRECT_URI/?code=CODE

  Step 3 -Your server should exchange the code it got in step 2 for an access token.

https://foursquare.com/oauth2/access_token
    ?client_id=YOUR_CLIENT_ID
    &client_secret=YOUR_CLIENT_SECRET
    &grant_type=authorization_code
    &redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    &code=CODE
The response will be JSON.
{ "access_token": ACCESS_TOKEN }
=end 

  
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


#This is a separate exampe for refactoring another controller - searches 

  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end

end 