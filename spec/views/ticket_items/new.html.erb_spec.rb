require 'rails_helper'

RSpec.describe "ticket_items/new", type: :view do
  before(:each) do
    assign(:ticket_item, TicketItem.new())
  end

  it "renders new ticket_item form" do
    render

    assert_select "form[action=?][method=?]", ticket_items_path, "post" do
    end
  end
end
