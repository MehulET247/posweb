class Setting
  include Mongoid::Document
  field :app_name, type: String
  field :app_api_key, type: String

  validates :app_name, presence: true, blank: false
  validates :app_api_key, presence: true, blank: false
end
