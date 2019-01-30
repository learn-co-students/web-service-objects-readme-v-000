class TipsController < ApplicationController
  def index
    foursquare = Foursquare.new
    @results = foursquare.results!(token)
  end

  def create
    foursquare = Foursquare.new
    foursquare.tips!(token, venue_id, tip)
    redirect_to tips_path
  end
end
