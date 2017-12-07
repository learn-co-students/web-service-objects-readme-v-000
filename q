
[1mFrom:[0m /home/zcdrake/Develop/Rails_and_Javascript/00_myStuff/04_consuming_APIs/web-service-objects-readme-v-000/app/controllers/searches_controller.rb @ line 20 SearchesController#foursquare:

    [1;34m11[0m: [32mdef[0m [1;34mfoursquare[0m
    [1;34m12[0m:   foursquare = [1;34;4mFoursquareService[0m.new
    [1;34m13[0m:   resp = foursquare.search(
    [1;34m14[0m:     [1;36mENV[0m[[31m[1;31m'[0m[31mFOURSQUARE_CLIENT_ID[1;31m'[0m[31m[0m],
    [1;34m15[0m:     [1;36mENV[0m[[31m[1;31m'[0m[31mFOURSQUARE_SECRET[1;31m'[0m[31m[0m],
    [1;34m16[0m:     params[[33m:zipcode[0m],
    [1;34m17[0m:     [31m[1;31m'[0m[31mcoffee shop[1;31m'[0m[31m[0m
    [1;34m18[0m:   )
    [1;34m19[0m:   binding.pry
 => [1;34m20[0m:   [32mif[0m resp.success?
    [1;34m21[0m:     @venues = resp[[31m[1;31m"[0m[31mresponse[1;31m"[0m[31m[0m][[31m[1;31m"[0m[31mvenues[1;31m"[0m[31m[0m]
    [1;34m22[0m:   [32melse[0m
    [1;34m23[0m:     @error = resp[[31m[1;31m"[0m[31mmeta[1;31m"[0m[31m[0m][[31m[1;31m"[0m[31merrorDetail[1;31m"[0m[31m[0m]
    [1;34m24[0m:   [32mend[0m
    [1;34m25[0m:   render [31m[1;31m'[0m[31msearch[1;31m'[0m[31m[0m
    [1;34m26[0m: 
    [1;34m27[0m:   [32mrescue[0m [1;34;4mFaraday[0m::[1;34;4mTimeoutError[0m
    [1;34m28[0m:     @error = [31m[1;31m"[0m[31mThere was a timeout. Please try again.[1;31m"[0m[31m[0m
    [1;34m29[0m:     render [31m[1;31m'[0m[31msearch[1;31m'[0m[31m[0m
    [1;34m30[0m: [32mend[0m

