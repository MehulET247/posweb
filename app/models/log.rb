class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :type, type: String

  validates :description, presence: :true, blank: false
  validates :type, presence: :true, blank: false
end
