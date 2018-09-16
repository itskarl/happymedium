class ItinerariesController < ApplicationController 

  def index 

  end

  def show

  end 

  def new
    @itinerary = Itinerary.new
  end

  def create 
    @itinerary = Itinerary.new(itinerary_params)

    respond_to do |format|
      if @itinerary.save
        p "Itinerary Created!"
        format.html { redirect_to root_path }
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
    params.require(:itinerary).permit(:name)
  end

end
