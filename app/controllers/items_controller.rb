class ItemsController < ApplicationController
  # GET /items
  def index
    @location = Location.first

    if @location
      @categories = @location.categories
      if params[:category].present?
        @category = @location.categories.where(name: params[:category]).first
        @items = @category.items
      else
        @items = @location.items
      end
    else
      @items = []
      @categories = []
    end
  end
end
