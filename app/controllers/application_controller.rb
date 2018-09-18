class ApplicationController < ActionController::Base
  include SessionsHelper
  # TODO: changed location from yelp API call to take in longitude and latitude

  def fetch_api_data
    searched = params[:search]
    query = searched.gsub(/\W/, '-') unless searched.nil?
    cost = []
    loc_miles = params[:miles_away].to_i/0.00062137 if !params[:miles_away].nil?
    event_miles = params[:miles_away]
    p loc_miles
    event_cost = ''

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




    p cost.count

    destination = if params[:location].nil?
                    'new+york'
                  else
                    params[:location].gsub(/\W/, '-')
                end
    # TODO: just revert location back to #{destination} later on

    if cost.count > 1
      @response = RestClient::Request.execute(
        method: :get,

        url: "https://api.yelp.com/v3/businesses/search?term=#{query}&location=new+york&open_now=true&limit=5&price=#{cost[0]},#{cost[1]}&#{filter[0]},#{filter[1]},#{filter[2]}&radius=#{loc_miles}",

        headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
      )
    else
      @response = RestClient::Request.execute(
        method: :get,

        url: "https://api.yelp.com/v3/businesses/search?term=#{query}&location=new+york&open_now=true&limit=50&price=#{cost[0]}&#{filter[0]},#{filter[1]},#{filter[2]}&radius=#{loc_miles}",

        headers: { 'Authorization' => 'Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx' }
      )
    end


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

    event_brite_loc = @address_one.gsub(/\W/, '-') unless @address_one.nil?
    @datae = Curl::Easy.perform("https://www.eventbriteapi.com/v3/events/search/?q=#{query}&sort_by=best&location.address=#{event_brite_loc}&price=#{event_cost}&token=FGTPMLNV7K6MQVZZCC6S")

    @req = JSON.parse(@datae.body_str)
    randevent = @req['events'].sample
    @event_img = randevent['logo']['url']
    @event_name = randevent['name']['text']
    @event_desc = randevent['description']['text'].byteslice(0..150)
    @event_start = (Time.parse(randevent['start']['local'])).strftime('%B, %d %Y %l:%M%P')
    @event_end = (Time.parse(randevent['end']['local'])).strftime('%B, %d %Y %l:%M%P')
    @event_free = randevent['is_free']
  end
end
