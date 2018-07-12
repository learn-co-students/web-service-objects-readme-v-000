class SessionsController < ApplicationController
  skip_before_action :authenticate_user

 def create
    foursquare = FoursquareService.new
      session[:token] = foursquare.authenticate!(ENV['KMYAOVQMHM1IOSSBT3QMFNFDXC5CBEWOLAAGJGQK2O30LXLQ'], ENV['KM1DWVJ5VLGZIYH5VA4LB51IWPUZJCJNV2JKATFBPE2INDKM'], params[:code])
    redirect_to root_path
  end

end
