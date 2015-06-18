require 'rails_helper'

RSpec.describe "ticket_items/show", type: :view do
  before(:each) do
    @ticket_item = assign(:ticket_item, TicketItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
