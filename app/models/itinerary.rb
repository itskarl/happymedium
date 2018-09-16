class Itinerary < ApplicationRecord
  after_initialize :set_default_name, unless: :persisted? 
  # before_save :set_default_name
  # belongs_to :user
  has_many :events


  private 

  # I guess in a way, this self.name is locked on the input field already as Itinerary so it wouldn't be left blank. If erased and left blank, it returns an empty string 
  # At least it is saving the name! THANK THE HEAVENS! 

  def set_default_name    
      self.name ||= "Itinerary" 
  end

end
