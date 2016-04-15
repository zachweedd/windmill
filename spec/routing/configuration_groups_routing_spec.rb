require "rails_helper"

RSpec.describe ConfigurationGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/configuration_groups").to route_to("configuration_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/configuration_groups/new").to route_to("configuration_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/configuration_groups/1").to route_to("configuration_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/configuration_groups/1/edit").to route_to("configuration_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/configuration_groups").to route_to("configuration_groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/configuration_groups/1").to route_to("configuration_groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/configuration_groups/1").to route_to("configuration_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/configuration_groups/1").to route_to("configuration_groups#destroy", :id => "1")
    end

  end
end
