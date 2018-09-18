class PagesController < ApplicationController


  def home

    # Transferred API call to Application Controller. Still works the same but we will now have a less bulky PagesController
    # I might even transfer it to a concern later on
    fetch_api_data

    @event = Event.new
    @itinerary = Itinerary.new
    @itinerary_index = Itinerary.all

  end

  def meetup
    if params[:address1] && params[:address2]
    locale1 = Geocoder.coordinates("#{params[:address1]}")
    locale2 = Geocoder.coordinates("#{params[:address2]}")
    new_lat = (locale1[0] + locale2[0])/2
    new_long = (locale1[1] + locale2[1])/2
    p new_lat
    p new_long

    @meet_response = RestClient::Request.execute(
      method: :get,
      url: "https://api.yelp.com/v3/businesses/search?latitude=#{new_lat}&longitude=#{new_long}&open_now=true&limit=20&radius=1609",
      headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
    )

    @meet_data = JSON.parse(@meet_response)
    
    end

  end



end
