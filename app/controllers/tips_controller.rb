class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.all_tips(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    tip = foursquare.create_tip(session[:token], params[:venue_id], params[:tip])

    if !tip.success?
      @error = "There was an error with your tip. Please try again."
    end

    @results = foursquare.all_tips(session[:token])

    render "index"
  end
end
