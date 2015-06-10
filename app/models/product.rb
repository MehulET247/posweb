class Product
  include Mongoid::Document

  field :name, type: String, default: ""
  field :id, type: String, default: "" 
end
