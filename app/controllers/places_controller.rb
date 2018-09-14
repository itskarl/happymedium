class PlacesController < ApplicationController
  def index
    @places = Place.order('created_at DESC')

    @data = Curl::Easy.perform("https://api.foursquare.com/v2/venues/explore?client_id=MX0ZI1L0F3JCH1PKERLTESHN4IGNQVW0HUDWSGVCJT343TFH&client_secret=SOXTW42PVMRQCVXGHZJLDLZE24HFJIGHYU3IMA3GBYASESDM&v=20180323&limit=10&ll=40.7243,-74.0018&query=dinner")
    @req = JSON.parse(@data.body_str)

    @data2 = Curl::Easy.perform("https://api.foursquare.com/v2/venues/explore?client_id=MX0ZI1L0F3JCH1PKERLTESHN4IGNQVW0HUDWSGVCJT343TFH&client_secret=SOXTW42PVMRQCVXGHZJLDLZE24HFJIGHYU3IMA3GBYASESDM&v=20180323&limit=10&ll=40.7243,-74.0018&query=drinks")
    @req2 = JSON.parse(@data.body_str)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = "Place added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  private

  def place_params
    params.require(:place).permit(:title, :address, :visited_by)
  end
end
