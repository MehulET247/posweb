class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :ticket_items

  field :status, type: String, default: "Draft"
  field :omnivore_id, type: String

end
