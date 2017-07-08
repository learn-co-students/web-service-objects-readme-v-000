class TipsController < ApplicationController
  def index
    index = FoursquareService.new
    
    @results = index.tips(session[:token])
  end

  def create
    new_tip = FoursquareService.new
    
    new_tip.create_tip(session[:token], params[:venue_id], params[:tip])
    
    redirect_to tips_path
  end
end
