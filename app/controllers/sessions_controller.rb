class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    redirect_to root_path
  end
end
