class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  # def full_address
  # [country, city, street].compact.join(‘, ‘)
  # end
  # geocoded_by :full_address

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

end
