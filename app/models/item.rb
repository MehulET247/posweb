class Item
  include Mongoid::Document
  field :id, type: String
  field :name, type: String
  field :price, type: Integer
  field :in_stock, type: Mongoid::Boolean
end
