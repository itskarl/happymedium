class AddEventsListToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :events_list, :json
  end
end
