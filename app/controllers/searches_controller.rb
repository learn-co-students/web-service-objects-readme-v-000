class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"
    zipcode = params[:zipcode]
    query = 'coffee shop'

    foursquare = FoursquareService.new
    response = foursquare.search(client_id, client_secret, zipcode, query)

    # FoursquareService.search returns a hash with a success bool and body of venues/error
    if response[:success]
      @venues = response[:body]
    else
      @error = response[:body]
    end

    render 'search'
  end
end
