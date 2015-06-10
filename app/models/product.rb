class Product
  include Mongoid::Document

  field :name, type: String, default: ""
  field :price, type: Decimal, default: ""
  field :id, type: String, default: "" 
end
