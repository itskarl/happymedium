class PagesController < ApplicationController
  
  

  def home
    
    # Transferred API call to Application Controller. Still works the same but we will now have a less bulky PagesController
    # I might even transfer it to a concern later on
    fetch_api_data 

    @itinerary = Itinerary.new
    @itinerary = Itinerary.where(params[:id])

  end

end
