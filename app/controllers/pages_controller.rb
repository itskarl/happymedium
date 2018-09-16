class PagesController < ApplicationController
  
  

  def home
    
    fetch_api_data

    new_itinerary

    @itinerary = Itinerary.where(params[:id])

  end

  def new_itinerary
    @itinerary = Itinerary.new
  end

end
