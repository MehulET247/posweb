class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_ticket

  def current_ticket
    if session[:ticket_id].present?
      begin
        Ticket.find(session[:ticket_id])
      rescue Mongoid::Errors::DocumentNotFound
        ticket = Ticket.create
        session[:ticket_id] = ticket._id
        ticket
      end
    else
      ticket = Ticket.create
      session[:ticket_id] = ticket._id
      ticket
    end
  end

end
