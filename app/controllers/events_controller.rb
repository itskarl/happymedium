class EventsController < ApplicationController 


  def new 
    @event = Event.new
  end

  def create 
    fetch_api_data
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save 
        p "Event saved!"
        format.html { redirect_to itinerary_show_path(@event.itinerary_id) }
      else 
        p "HAHA GOODLUCK!"
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to itinerary_show_path(@event.itinerary_id) }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :image_url, :itinerary_id)
  end
end