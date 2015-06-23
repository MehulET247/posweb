class TicketsController < ApplicationController
  before_filter :authenticate_user!

  # GET /tickets
  def index
    @tickets = current_user.tickets.where(status: "Complete").order(updated_at: :desc)
  end

  def current
    @ticket = current_ticket
  end

  def payment
    require 'rest_client'
    require "json"

    items = []

    current_ticket.ticket_items.each do |ticket_item|
      item = {
        menu_item: ticket_item.omnivore_id,
        quantity: ticket_item.quantity
      }

      items << item
    end

    payload = {
      employee: "xET7jTqk",
      order_type: "jLTqoTba",
      revenue_center: "gdTMpTKz"
    }

    # Open a new ticket
    response = RestClient.post(
      "https://api.omnivore.io/0.1/locations/#{Location.first.omnivore_id}/tickets",
      payload.to_json, {:content_type => :json, :'Api-Key' => Setting.first.app_api_key}
    )

    @response = JSON.parse(response)

    # Add ticket items to ticket
    RestClient.post(
      "https://api.omnivore.io/0.1/locations/#{Location.first.omnivore_id}/tickets/#{@response['id']}/items",
      items.to_json,
      {:content_type => :json, :'Api-Key' => Setting.first.app_api_key}
    )

    payment = {
      type: "card_not_present",
      amount: (current_ticket.ticket_items.inject(0) { |sum, ti| sum + (ti.price * ti.quantity) }),
      tip: (params[:tip]*100).to_i,
      card_info: {
        exp_month: params[:date][:expiration_month].to_i,
        exp_year: params[:date][:expiration_year].to_i,
        cvc2: params[:cvc],
        number: params[:card_number]
      }
    }

    # Send payment info
    begin
      payment_response = RestClient.post(
        "https://api.omnivore.io/0.1/locations/#{Location.first.omnivore_id}/tickets/#{@response['id']}/payments/",
        payment.to_json,
        {:content_type => :json, :'Api-Key' => Setting.first.app_api_key}
      )
    rescue
      redirect_to current_tickets_url, alert: "Payment could not be processed. Please check payment data and try again." and return
    end

    current_ticket.update_attributes(
      status: "Complete",
      user: current_user,
      omnivore_id: @response["id"]
    )

    @payment_response = JSON.parse(payment_response)

    session[:ticket_id] = nil

  end

  def confirm

  end

end
