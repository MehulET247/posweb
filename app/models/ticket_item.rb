class TicketItem
  include Mongoid::Document

  belongs_to :ticket
  belongs_to :item

  field :omnivore_id, type: String
  field :name, type: String
  field :price, type: Integer
  field :quantity, type: Integer
end
