require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        :id => "Id",
        :name => "Name",
        :price => 1,
        :in_stock => false
      ),
      Item.create!(
        :id => "Id",
        :name => "Name",
        :price => 1,
        :in_stock => false
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
