class ItemsController < ApplicationController
  # GET /items
  def index
    @items = Item.all
  end
end
