class Location
  include Mongoid::Document
  
  field :location_id, type: String
  field :location_name, type: String

  validates :location_id, presence: true, uniqueness: true, blank: false
  validates :location_name, presence: true, uniqueness: true, blank: false
end
