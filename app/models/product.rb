class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :id, type: Integer
  field :price, type: Money
  field :in_stock, type: Boolean, default: false

  validates :name, presence: true, blank: false
  validates :id, presence: true, uniqueness: true, blank: false
end
