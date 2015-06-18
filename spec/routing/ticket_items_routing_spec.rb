require "rails_helper"

RSpec.describe TicketItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ticket_items").to route_to("ticket_items#index")
    end

    it "routes to #new" do
      expect(:get => "/ticket_items/new").to route_to("ticket_items#new")
    end

    it "routes to #show" do
      expect(:get => "/ticket_items/1").to route_to("ticket_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ticket_items/1/edit").to route_to("ticket_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ticket_items").to route_to("ticket_items#create")
    end

    it "routes to #update" do
      expect(:put => "/ticket_items/1").to route_to("ticket_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ticket_items/1").to route_to("ticket_items#destroy", :id => "1")
    end

  end
end
