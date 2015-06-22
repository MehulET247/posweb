class TicketItemsController < ApplicationController
  before_action :set_ticket_item, only: [:show, :edit, :update, :destroy]

  # GET /ticket_items
  def index
    @ticket_items = TicketItem.all
  end

  # GET /ticket_items/1
  def show
  end

  # GET /ticket_items/new
  def new
    @ticket_item = TicketItem.new
  end

  # GET /ticket_items/1/edit
  def edit
  end

  # POST /ticket_items
  def create
    @item = Item.find(params[:ticket_item][:item_id])

    @ticket_item = current_ticket.ticket_items.where(item_id: @item._id).first || TicketItem.new

    @ticket_item.item = @item
    @ticket_item.omnivore_id = @item.omnivore_id
    @ticket_item.name = @item.name
    @ticket_item.price = @item.price

    if @ticket_item.quantity.present?
      @ticket_item.quantity += params[:ticket_item][:quantity].to_i
    else
      @ticket_item.quantity = params[:ticket_item][:quantity].to_i
    end

    @ticket_item.ticket = current_ticket

    if @ticket_item.save
      redirect_to root_url, notice: 'Item was successfully added.'
    else
      render :new
    end
  end

  # PATCH/PUT /ticket_items/1
  def update
    if @ticket_item.update(ticket_item_params)
      redirect_to current_tickets_url, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ticket_items/1
  def destroy
    @ticket_item.destroy
    redirect_to tickets_url, notice: 'Item was successfully removed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket_item
    @ticket_item = TicketItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def ticket_item_params
    params.require(:ticket_item).permit(:ticket_id, :item_id, :omnivore_id, :name, :price, :quantity)
  end
end
