require 'rails_helper'

RSpec.describe "logs/index", type: :view do
  before(:each) do
    assign(:logs, [
      Log.create!(
        :description => "MyText"
      ),
      Log.create!(
        :description => "MyText"
      )
    ])
  end

  it "renders a list of logs" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
