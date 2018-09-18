class ItinerariesController < ApplicationController 


  def index 
    @itineraries = Itinerary.all
  end

  def show
    fetch_api_data
    @itinerary = Itinerary.find(params[:id])
    @events = @itinerary.events 
  end 

  def new
    @itinerary = Itinerary.new
  end

  def create 
    @itinerary = Itinerary.new(itinerary_params)
    current_user = session[:user_id]
    if current_user
      @itinerary.user_id = current_user
    end
    respond_to do |format|
      if @itinerary.save
        p "Itinerary Created!"
        format.html { redirect_to @itinerary }
      else
        p "Nope"
        format.html { render :new }
      end
    end
  end

  def edit 

  end

  def update

  end

  def destroy

  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, 
                                    events_attributes: [:id, :name, :address, :image_url])
  end

end
