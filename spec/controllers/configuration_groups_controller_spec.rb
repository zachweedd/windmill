require 'rails_helper'

RSpec.describe ConfigurationGroupsController, :controller do
  let(:valid_attributes) {
    { name: 'test group' }
  }

  let(:invalid_attributes) {
    { some_thing: 'some other thing' }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all configuration_groups as @configuration_groups" do
      configuration_group = ConfigurationGroup.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:configuration_groups)).to eq([configuration_group])
    end
  end

  describe "GET #show" do
    it "assigns the requested configuration_group as @configuration_group" do
      configuration_group = ConfigurationGroup.create! valid_attributes
      get :show, { id: configuration_group.to_param }, valid_session
      expect(assigns(:configuration_group)).to eq(configuration_group)
      expect(assigns(:clients)).to eq(configuration_group.clients)
    end
  end

  describe "GET #new" do
    it "assigns a new configuration_group as @configuration_group" do
      get :new, {}, valid_session
      expect(assigns(:configuration_group)).to be_a_new(ConfigurationGroup)
    end
  end

  describe "GET #edit" do
    it "assigns the requested configuration_group as @configuration_group" do
      configuration_group = ConfigurationGroup.create! valid_attributes
      get :edit, { id: configuration_group.to_param }, valid_session
      expect(assigns(:configuration_group)).to eq(configuration_group)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ConfigurationGroup" do
        expect {
          post :create, { configuration_group: valid_attributes }, valid_session
        }.to change(ConfigurationGroup, :count).by(1)
      end

      it "assigns a newly created configuration_group as @configuration_group" do
        post :create, { configuration_group: valid_attributes }, valid_session
        expect(assigns(:configuration_group)).to be_a(ConfigurationGroup)
        expect(assigns(:configuration_group)).to be_persisted
      end

      it "redirects to the created configuration_group" do
        post :create, { configuration_group: valid_attributes }, valid_session
        expect(response).to redirect_to(ConfigurationGroup.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved configuration_group as @configuration_group" do
        post :create, { configuration_group: invalid_attributes }, valid_session
        expect(assigns(:configuration_group)).to be_a_new(ConfigurationGroup)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'new name' }
      }

      it "updates the requested configuration_group" do
        configuration_group = ConfigurationGroup.create! valid_attributes
        put :update, { id: configuration_group.to_param, configuration_group: new_attributes }, valid_session
        expect(configuration_group.reload.name).to eq 'new name'
      end

      it "assigns the requested configuration_group as @configuration_group" do
        configuration_group = ConfigurationGroup.create! valid_attributes
        put :update, { id: configuration_group.to_param, configuration_group: valid_attributes }, valid_session
        expect(assigns(:configuration_group)).to eq(configuration_group)
      end

      it "redirects to the configuration_group" do
        configuration_group = ConfigurationGroup.create! valid_attributes
        put :update, { id: configuration_group.to_param, configuration_group: valid_attributes }, valid_session
        expect(response).to redirect_to(configuration_group)
      end
    end

    context "with invalid params" do
      it "assigns the configuration_group as @configuration_group" do
        configuration_group = ConfigurationGroup.create! valid_attributes
        put :update, { id: configuration_group.to_param, configuration_group: invalid_attributes }, valid_session
        expect(assigns(:configuration_group)).to eq(configuration_group)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested configuration_group" do
      configuration_group = ConfigurationGroup.create! valid_attributes
      expect {
        delete :destroy, { id: configuration_group.to_param }, valid_session
      }.to change(ConfigurationGroup, :count).by(-1)
    end

    it "redirects to the configuration_groups list" do
      configuration_group = ConfigurationGroup.create! valid_attributes
      delete :destroy, { id: configuration_group.to_param }, valid_session
      expect(response).to redirect_to(configuration_groups_url)
    end
  end

end
