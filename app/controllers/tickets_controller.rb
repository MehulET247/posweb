class TicketsController < ApplicationController

  # GET /tickets
  def index
    @ticket = current_ticket
  end

end
