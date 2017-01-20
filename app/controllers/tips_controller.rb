class TipsController < ApplicationController
  def index
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20160201'
    end
    @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def create
    foursquare = FoursquareService.new
    resp = foursquare.tips(session[:token], params[:venue_id], params[:tip])
    redirect_to tips_path
  end
end
