class ApplicationController < ActionController::Base
  include SessionsHelper
  # TODO: changed location from yelp API call to take in longitude and latitude

  def fetch_api_data
    searched = params[:search]
    query = searched.gsub(/\W/, '-') unless searched.nil?
    cost = []
    loc_miles = params[:miles_away].to_i/0.00062137 if !params[:miles_away].nil?
    event_miles = params[:miles_away]
    # p loc_miles
    # p params[:miles_away]

    #Searching by Date---
    today = Date.today()
    Time.now + 3.days
    @day3 = (today+2).strftime('%m/%d/%C')
    @day4 = (today+3).strftime('%m/%d/%C')
    @day5 = (today+4).strftime('%m/%d/%C')
    event_cost = ''

      if params[:day].nil? || params[:day] == '0'
        day = 0

        p event_day = Time.now.utc.iso8601
        p sec_event_day = (Time.now + 1.day).utc.iso8601
      elsif params[:day] == '8'
        day = params[:day].to_i
        p event_day = (Time.now + 1.day).utc.iso8601
        p sec_event_day = (Time.now + 2.day).utc.iso8601
      elsif params[:day] == '16'
        day = params[:day].to_i
        p event_day = (Time.now + 2.days).utc.iso8601
        p sec_event_day = (Time.now + 3.days).utc.iso8601
      elsif params[:day] == '24'
        day = params[:day].to_i
        p event_day = (Time.now + 3.days).utc.iso8601
        p sec_event_day = (Time.now + 4.days).utc.iso8601
      elsif params[:day] == '32'
        day = params[:day].to_i
        p event_day = (Time.now + 4.days).utc.iso8601
        p sec_event_day = (Time.now + 5.days).utc.iso8601
      end
    #---------
      if params[:filter].nil?
        filter = ''
      else
        filter = params[:filter]
      end

       if params[:cost].nil?
          cost = [1,2,3]
          event_cost = ''
       elsif params[:cost].count == 1
         cost = params[:cost]
       else
          params[:cost].each do |param|
            cost<< param
          end

          if cost.count > 2
            event_cost = 'paid+free'
          elsif cost.count == 1 && cost[0] == '1'
            event_cost = 'free'
          elsif cost.count == 2 && cost.all?{|val| val != 1}
            event_cost = 'paid'
          else
            event_cost = 'paid+free'
          end
        end



#----location search
    p cost.count

    if params[:location].nil?
      destination = 'new+york'
      p params[:location]
    else
      p destination = params[:location].gsub(/\W/, '-')
    end
#------
    # TODO: just revert location back to #{destination} later on
#-----Yelp API---
    if cost.count > 1
      @response = RestClient::Request.execute(
        method: :get,

        url: "https://api.yelp.com/v3/businesses/search?term=#{query}&location=#{destination}&open_now=true&limit=50&price=#{cost[0]},#{cost[1]}&#{filter[0]},#{filter[1]},#{filter[2]}&radius=#{loc_miles.to_i}",

        headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
      )
    else
      @response = RestClient::Request.execute(
        method: :get,

        url: "https://api.yelp.com/v3/businesses/search?term=#{query}&location=#{destination}&open_now=true&limit=50&price=#{cost[0]}&#{filter[0]},#{filter[1]},#{filter[2]}&radius=#{loc_miles.to_i}",

        headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
      )
    end
#------
#---Event Brite API
    @data = JSON.parse(@response)
    @locationOne = @data.first[1][rand(0...@data.first[1].count)]
    @locationTwo = @data.first[1][rand(0...@data.first[1].count)]

    until @locationOne != @locationTwo
      @locationTwo = @data.first[1][rand(0...@data.first[1].count)]
    end
    @loc_one = @locationOne['name']
    @loc_two = @locationTwo['name']
    @loc_one_img = @locationOne['image_url']
    @loc_two_img = @locationTwo['image_url']
    @address_one = @locationOne['location']['display_address'][0] + ", "+ @locationOne['location']['display_address'][1]
    @address_two = @locationTwo['location']['display_address'][0] + ", "+ @locationOne['location']['display_address'][1]
    @loc_one_price = @locationOne['price']
    @loc_two_price = @locationTwo['price']
    @loc_one_distance = (@locationOne['distance'] * 0.00062137).round(2)
    @loc_two_distance = (@locationTwo['distance'] * 0.00062137).round(2)
    @data.first[1].count


    event_brite_loc = @locationOne['location']['city'].gsub(/\W/, '-') unless @locationOne.nil?
    p event_brite_loc
    @datae = Curl::Easy.perform("https://www.eventbriteapi.com/v3/events/search/?q=#{query}&sort_by=best&location.address=#{event_brite_loc}&price=#{event_cost}&start_date.range_start=#{event_day}&start_date.range_end=#{sec_event_day}&token=FGTPMLNV7K6MQVZZCC6S")
    p @datae

    @req = JSON.parse(@datae.body_str)
    randevent = @req['events'].sample unless @req.nil?
    @event_img = randevent['logo']['url'] if !randevent['logo'].nil?
    @event_name = randevent['name']['text'] if !randevent.nil?
    @event_desc = randevent['description']['text'].byteslice(0..50) unless randevent['description']['text'].byteslice(0..50).nil?
    @event_start = (Time.parse(randevent['start']['local'])).strftime('%B, %d %Y %l:%M%P')
    @event_end = (Time.parse(randevent['end']['local'])).strftime('%B, %d %Y %l:%M%P')
    @event_free = randevent['is_free']
    @event_url = randevent['url']


    #weather API-------
    weather_city = @locationOne['location']['city'].gsub(/\W/, '+') unless @locationOne.nil?
    weather_country = @locationOne['location']['country'].gsub(/\W/, '-') unless @locationOne.nil?
    @weather_response = Curl::Easy.perform("api.openweathermap.org/data/2.5/forecast?q=#{weather_city},#{weather_country}&APPID=89e45d236787c5dece4d491bbac3120b")
    @weather_data = JSON.parse(@weather_response.body_str)
    @weather_description = @weather_data['list'][day]['weather'][0]['description']
    @weather_time = (Time.parse(@weather_data['list'][day]['dt_txt'])).strftime('%m/%d/%C')
    @weather_temp = (((@weather_data['list'][day]['main']['temp'] *9) /5).to_i - 459.67).round(0)
    weather_icon_url = @weather_data['list'][day]['weather'][0]['icon']
    @weather_icon = "http://openweathermap.org/img/w/#{weather_icon_url}.png"



  end
end
