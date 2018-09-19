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

    meetingt = params[:meettype]
    p params[:meettype]

    radius = 0
    @meet_response = nil

    until @middlelocation != nil
      @meet_response = RestClient::Request.execute(
        method: :get,
        url: "https://api.yelp.com/v3/businesses/search?term=#{meetingt}&latitude=#{new_lat}&longitude=#{new_long}&open_now=true&limit=20&radius=#{radius}",
        headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
      )
      p @meet_response
      radius += 1609
      p radius
      @meet_data = JSON.parse(@meet_response)
      @middlelocation = @meet_data.first[1].sample
    end
    end
  end




end
