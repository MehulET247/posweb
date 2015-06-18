require 'rails_helper'

RSpec.describe "TicketItems", type: :request do
  describe "GET /ticket_items" do
    it "works! (now write some real specs)" do
      get ticket_items_path
      expect(response).to have_http_status(200)
    end
  end
end
