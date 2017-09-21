class TipsController < ApplicationController
  def index
    tips = FoursquareService.new
    @tips = tips.list_tips(session[:token])
  end

  def create
    tips = FoursquareService.new
    @tip = tips.add_tip(session[:token], params[:venue_id], params[:tip])
  end
end
