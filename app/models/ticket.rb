class Ticket
  include Mongoid::Document
  has_many :ticket_items
end
