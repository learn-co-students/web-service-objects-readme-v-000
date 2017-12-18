class SearchesController < ApplicationController

  def search
  end

  def friends
    def friends
     foursquare = FoursquareService.new
     @friends = foursquare.friends(session[:token])
   end
  end

  def foursquare
    client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"

    foursquare = FoursquareService.new
    @venues, @error = foursquare.venue_searches(client_id, client_secret, params[:zipcode])

    render 'search'
  end
end
