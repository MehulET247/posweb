class Admin::TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.where(status: "Complete").order(updated_at: :desc)
  end
end
