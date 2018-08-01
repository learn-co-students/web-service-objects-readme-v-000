require 'pry'

class TipsController < ApplicationController
  def index
    foursquare = FoursquareService.new
    @results = foursquare.tipindex(session[:token])
  end

  def create
    foursquare = FoursquareService.new
    resp = foursquare.newtip(session[:token], params[:venue_id], params[:tip])
    binding.pry
    resp
    redirect_to tips_path
  end
end
