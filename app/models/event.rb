class Event < ApplicationRecord
  belongs_to :itinerary, optional: true

  validates_presence_of :itinerary_id
end
