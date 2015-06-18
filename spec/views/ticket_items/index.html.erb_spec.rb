require 'rails_helper'

RSpec.describe "ticket_items/index", type: :view do
  before(:each) do
    assign(:ticket_items, [
      TicketItem.create!(),
      TicketItem.create!()
    ])
  end

  it "renders a list of ticket_items" do
    render
  end
end
