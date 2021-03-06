require 'rails_helper'

RSpec.describe "logs/edit", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!(
      :description => "MyText"
    ))
  end

  it "renders the edit log form" do
    render

    assert_select "form[action=?][method=?]", log_path(@log), "post" do

      assert_select "textarea#log_description[name=?]", "log[description]"
    end
  end
end
