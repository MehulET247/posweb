class Category
  include Mongoid::Document

  belongs_to :location
  has_many :items, dependent: :destroy

  field :omnivore_id, type: String
  field :name, type: String
  field :still_present, type: Mongoid::Boolean, default: true

  validates :name, presence: true, uniqueness: true, blank: false
  validates :omnivore_id, presence: true, blank: false, uniqueness: {scope: [:location]}
end
