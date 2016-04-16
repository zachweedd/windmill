require 'rails_helper'

RSpec.describe "Configurations", type: :request do
  describe "GET /configurations" do
    it "works! (now write some real specs)" do
      get configurations_path
      expect(response).to have_http_status(200)
    end
  end
end
