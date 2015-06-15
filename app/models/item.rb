class Item
  include Mongoid::Document

  belongs_to :category
  has_many :modifier_groups, dependent: :destroy

  field :omnivore_id, type: String
  field :name, type: String
  field :price, type: Integer
  field :in_stock, type: Mongoid::Boolean
  field :still_present, type: Mongoid::Boolean, default: true

  validates :omnivore_id, presence: true, blank: false, uniqueness: {scope: [:category]}
  validates :name, presence: true, blank: false
  validates :price, presence: true, blank: false
  validates :in_stock, presence: true, blank: false
end
