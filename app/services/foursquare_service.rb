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
      # don't forget that pesky v param for versioning
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  def foursquare(zipcode, query)
    client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = zipcode
      req.params['query'] = query
    end
    
  end
end
