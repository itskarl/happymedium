class Itinerary < ApplicationRecord
  after_initialize :set_default_name, unless: :persisted? 
  # after_save :save_events
  # JUST FOR NOW
  belongs_to :user, optional: true
  has_many :events, dependent: :destroy

  accepts_nested_attributes_for :events, :allow_destroy => true
  validates_associated :events


  def event_attributes=(event_attributes)
    event_attributes.each do |attributes|
      events.build(attributes)
    end
  end

  private 

  # I guess in a way, this self.name is locked on the input field already as Itinerary so it wouldn't be left blank. If erased and left blank, it returns an empty string 
  # At least it is saving the name! THANK THE HEAVENS! 

  def set_default_name    
      self.name ||= "Itinerary" 
  end

  # def save_events 
  #   events.each do |event|
  #     event.save(false)
  #   end
  # end


end
