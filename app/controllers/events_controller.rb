class EventsController < ApplicationController 

  def new 
    @event = Event.new
  end

  def create 
    fetch_api_data
    @event = Event.new(event_params)
    @event.save!
    # @event.itinerary_id = @current_event.id
    # respond_to do |format|
    #   if @event.save 
    #     p "Event saved!"
    #     format.html { redirect_to root_path }
    #   else 
    #     p "HAHA GOODLUCK!"
    #     format.html { redirect_to root_path }
    #   end
    # end
  end

  private

  def event_params
    params.require(:event).permit(:name, :itinerary_id)
  end
end