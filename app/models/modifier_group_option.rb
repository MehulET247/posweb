class ModifierGroupOption
  include Mongoid::Document

  belongs_to :modifier_group

  field :omnivore_id, type: String
  field :name, type: String
  field :price_per_unit, type: Integer
  field :still_present, type: Mongoid::Boolean, default: true

  validates :omnivore_id, presence: true, uniqueness: {scope: [:modifier_group]}, blank: false

end
