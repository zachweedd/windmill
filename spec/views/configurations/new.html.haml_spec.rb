require 'rails_helper'

RSpec.describe "configurations/new", type: :view do
  before(:each) do
    assign(:configuration, Configuration.new())
  end

  it "renders new configuration form" do
    render

    assert_select "form[action=?][method=?]", configurations_path, "post" do
    end
  end
end
