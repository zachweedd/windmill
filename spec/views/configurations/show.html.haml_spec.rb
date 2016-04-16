require 'rails_helper'

RSpec.describe "configurations/show", type: :view do
  before(:each) do
    @configuration = assign(:configuration, Configuration.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
