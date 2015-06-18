require 'rails_helper'

RSpec.describe "ticket_items/edit", type: :view do
  before(:each) do
    @ticket_item = assign(:ticket_item, TicketItem.create!())
  end

  it "renders the edit ticket_item form" do
    render

    assert_select "form[action=?][method=?]", ticket_item_path(@ticket_item), "post" do
    end
  end
end
