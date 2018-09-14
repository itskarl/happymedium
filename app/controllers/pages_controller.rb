class PagesController < ApplicationController
  def home
    searched = params[:search]
    @response = RestClient::Request.execute(
      method: :get,
      url: "https://api.yelp.com/v3/businesses/search?term=#{searched}&location=brooklyn&open_now=true",
      headers: {"Authorization" => "Bearer N8S3U6LDLLsusNB1-x8lUUwT6VzK8Vrz_jVDrcHKceg6GdJl7--ETsNeFQ1VBFG39Vy_aPd3NuKSBXln5XdH43hbescROWi4NKTPok0KEkxDXsisrsdU7kOJ-KaaW3Yx"}
      )
      @data = JSON.parse(@response)
      @locationOne = @data.first[1][rand(0...@data.first[1].count)]
      @locationTwo = @data.first[1][rand(0...@data.first[1].count)]
      @loc_one = @locationOne['name']
      @loc_two = @locationTwo['name']
      @loc_one_img = @locationOne['image_url']
      @loc_one_img = @locationTwo['image_url']
      @address_one = @locationOne['location']['display_address'][0]
      @address_two = @locationTwo['location']['display_address'][0]
  end
end
