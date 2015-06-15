class Item
  include Mongoid::Document
  field :item_id, type: String
  field :item_name, type: String
  field :item_price, type: Integer
  field :item_in_stock, type: Mongoid::Boolean
end
