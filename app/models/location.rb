class Location
  include Mongoid::Document

  has_many :categories, dependent: :destroy

  field :omnivore_id, type: String
  field :name, type: String

  validates :omnivore_id, presence: true, uniqueness: true, blank: false
  validates :name, presence: true, uniqueness: true, blank: false

  def items
    self.categories.inject([]) {|items, cat| items + cat.items}
  end

  def modifier_groups
    self.items.inject([]) {|modifier_groups, item| modifier_groups + item.modifier_groups}
  end

  def get_data
    get_menu_category
    get_menu_items
    get_item_modifier_groups
    get_modifier_group_options
  end

  #Get location menu categories

  def get_menu_category
    require "rest_client"
    require "json"

    self.categories.update_all(still_present: false)
    response = RestClient.get("https://api.omnivore.io/0.1/locations/#{self.omnivore_id}/menu/categories", {:content_type => :json, :'Api-Key' => Setting.first.app_api_key})
    res = JSON.parse(response)
    res["_embedded"]["categories"].each do |category|
      cat = self.categories.where(omnivore_id: category["id"]).first_or_create
      cat.name = category["name"]
      cat.still_present = true
      cat.save
    end

    self.categories.where(still_present: false).destroy_all
  end

  def get_menu_items
    require "rest_client"
    require "json"

    self.categories.each do |category|
      category.items.update_all(still_present: false)

      response = RestClient.get("https://api.omnivore.io/0.1/locations/#{self.omnivore_id}/menu/categories/#{category.omnivore_id}/items", {:content_type => :json, :'Api-Key' => Setting.first.app_api_key})

      res = JSON.parse(response)

      res["_embedded"]["menu_items"].each do |item|
        i = category.items.where(omnivore_id: item["id"]).first_or_create
        i.name = item["name"]
        i.price = item["price"]
        i.in_stock = item["in_stock"]
        i.still_present = true
        i.save
      end

      category.items.where(still_present: false).destroy_all
    end

  end

  def get_item_modifier_groups
    self.items.each do |item|
      item.modifier_groups.update_all(still_present: false)

      response = RestClient.get("https://api.omnivore.io/0.1/locations/#{self.omnivore_id}/menu/items/#{item.omnivore_id}/modifier_groups/", {:content_type => :json, :'Api-Key' => Setting.first.app_api_key})
      res = JSON.parse(response)

      res["_embedded"]["modifier_groups"].each do |mg|
        mod_grp = item.modifier_groups.where(omnivore_id: mg["id"]).first_or_create
        mod_grp.name = mg["name"]
        mod_grp.required = mg["required"]
        mod_grp.maximum = mg["maximum"]
        mod_grp.minimum = mg["minimum"]
        mod_grp.still_present = true
        mod_grp.save
      end

      item.modifier_groups.where(still_present: false).destroy_all
    end
  end

  def get_modifier_group_options
    self.modifier_groups.each do |mg|
      mg.modifier_group_options.update_all(still_present: false)

      response = RestClient.get("https://api.omnivore.io/0.1/locations/#{self.omnivore_id}/menu/items/#{mg.item.omnivore_id}/modifier_groups/#{mg.omnivore_id}/modifiers", {:content_type => :json, :'Api-Key' => Setting.first.app_api_key})
      res = JSON.parse(response)

      res["_embedded"]["modifiers"].each do |option|
        opt = mg.modifier_group_options.where(omnivore_id: option["id"]).first_or_create
        opt.name = option["name"]
        opt.price_per_unit = option["price_per_unit"]
        opt.still_present = true
        opt.save
      end

      mg.modifier_group_options.where(still_present: false).destroy_all
    end
  end

end
