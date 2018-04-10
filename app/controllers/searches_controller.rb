class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new 
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    #client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    #client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"
    foursquare = FoursquareService.new 
    @friends = foursquare.search(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:zipcode]) 
    render 'search' 
  end
end
