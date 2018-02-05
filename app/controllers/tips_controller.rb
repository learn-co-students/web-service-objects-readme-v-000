class TipsController < ApplicationController
  def index
    @results = FoursquareService.new.user_tips(session[:token])
  end

  def create
    FoursquareService.new.create_tip(session[:token],params[:venue_id],params[:tip])
    redirect_to tips_path
  end
end
