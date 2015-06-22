class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

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
