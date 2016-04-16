require 'rails_helper'

RSpec.describe "configurations/index", type: :view do
  before(:each) do
    assign(:configurations, [
      Configuration.create!(),
      Configuration.create!()
    ])
  end

  it "renders a list of configurations" do
    render
  end
end
