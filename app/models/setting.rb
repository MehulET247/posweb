class Setting
  include Mongoid::Document

  field :app_name, type: String, default: ""
end
