class Itinerary < ApplicationRecord
  after_initialize :set_default_name
  # belongs_to :user
  has_many :events


  private 

  def set_default_name
    self.name = "Itinerary"
  end

end
