class TipsController < ApplicationController
  def index
    foursquare_object = FoursquareService.new
    @results = foursquare_object.tips(session[:token])
    binding.pry
  end

  def create
    foursquare_object = FoursquareService.new
    foursquare_object.create_tip(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
