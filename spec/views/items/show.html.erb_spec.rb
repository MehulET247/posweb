require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :id => "Id",
      :name => "Name",
      :price => 1,
      :in_stock => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Id/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
