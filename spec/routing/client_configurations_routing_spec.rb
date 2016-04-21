require "rails_helper"

RSpec.describe ClientConfigurationsController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/client_configurations/1").to route_to("client_configurations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/client_configurations/1/edit").to route_to("client_configurations#edit", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/client_configurations/1").to route_to("client_configurations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/client_configurations/1").to route_to("client_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/client_configurations/1").to route_to("client_configurations#destroy", :id => "1")
    end

  end
end
