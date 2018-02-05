class FoursquareService

  # Fetch the access token for client using the code returned by foursquare when the client authenticates our app. 
  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
    end
    body = JSON.parse(resp.body)
    return body["access_token"]
  end

  # Get the hash of client's foursquare friends
  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    return JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  # Returns hash with success bool and the contents(body response or error) based on that
  def search(client_id, client_secret, zipcode, query)
    begin
      resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
        req.params['v'] = '20160201'
        req.params['near'] = zipcode
        req.params['query'] = query
      end    

      body = JSON.parse(resp.body)

      # If response is successful, return the venues json returned. Otherwise return the error
      if resp.success?
        return {success: true, body: body["response"]["venues"]}
      else
        return {success: false, body: body["meta"]["errorDetail"]}
      end

    # Rescue client from potential timeout error when accessing foursquare api
    rescue Faraday::TimeoutError
      return {success: false, body: "There was a timeout. Please try again."}
    end

  end

  # Returns the hash of client's foursquare tips
  def get_tips(token)
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    return JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]    
  end

  # Adds the client's tip to foursquare venue
  def add_tip(token, venue_id, tip)
    Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
      req.params['venueId'] = venue_id
      req.params['text'] = tip
    end
  end

end