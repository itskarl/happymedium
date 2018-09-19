class Event < ApplicationRecord
  belongs_to :itinerary, optional: true

end
