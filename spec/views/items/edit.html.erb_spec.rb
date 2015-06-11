require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :id => "MyString",
      :name => "MyString",
      :price => 1,
      :in_stock => false
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input#item_id[name=?]", "item[id]"

      assert_select "input#item_name[name=?]", "item[name]"

      assert_select "input#item_price[name=?]", "item[price]"

      assert_select "input#item_in_stock[name=?]", "item[in_stock]"
    end
  end
end
