class FoursquareService
  
  def authenticate!(client_id,client_secret,code)
    resp=Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id']=client_secret
      req.params['grant_type']='authorization_code'
      req.params['redirect_uri']="http://localhost:3000/auth"
      req.params['code']=code
    end
    
    body=JSON.parse(resp.body)
    body['access_token']
  end
  
  def friends(token)
    
    #make a new get request to the endpoint specified in the docs
    resp=Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      #get the token handed as an argument
      req.params['oauth_token']=token
      
      #stupid v param
      req.params['v']='20160201'
    end
    
    #get specific record data as specified in the docs.
    #return the friends, that's what the method says it does...
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end
  
  def tips(token)
    
    #make the API call specified in docs
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      #proper authentication and versioning
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    
    #return the data to the controller. That's all I do! (That, and win....)
    JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end
  
  
end
