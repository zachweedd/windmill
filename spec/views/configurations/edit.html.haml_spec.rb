require 'rails_helper'

RSpec.describe "configurations/edit", type: :view do
  before(:each) do
    @configuration = assign(:configuration, Configuration.create!())
  end

  it "renders the edit configuration form" do
    render

    assert_select "form[action=?][method=?]", configuration_path(@configuration), "post" do
    end
  end
end
