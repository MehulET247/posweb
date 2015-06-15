class ModifierGroup
  include Mongoid::Document

  belongs_to :item
  has_many :modifier_group_options, dependent: :destroy

  field :omnivore_id, type: String
  field :name, type: String
  field :minimum, type: Integer
  field :maximum, type: Integer
  field :required, type: Mongoid::Boolean
  field :still_present, type: Mongoid::Boolean, default: true

  validates :omnivore_id, presence: true, uniqueness: {scope: [:item]}, blank: false

end
