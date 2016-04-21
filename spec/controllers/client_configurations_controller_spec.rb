require 'rails_helper'

RSpec.describe ClientConfigurationsController, :controller do
  let(:configuration_group){ create :configuration_group }

  let(:valid_attributes) {
    {
      name: 'test', version: '0.1', notes: 'test', config_json: {one: 'one'},
      configuration_group_id: configuration_group.id
    }
  }

  let(:invalid_attributes) {
    { wrong_attribute: 'test' }
  }

  let(:valid_session) { {} }

  before do
    sign_in :user, create(:user, :confirmed)
  end

  describe "GET #show" do
    it "assigns the requested client configuration as @client_configuration" do
      client_configuration = ClientConfiguration.create! valid_attributes
      get :show, {id: client_configuration.to_param }, valid_session
      expect(assigns(:client_configuration)).to eq(client_configuration)
    end
  end

  describe "GET #edit" do
    it "assigns the requested configuration as @configuration" do
      configuration = ClientConfiguration.create! valid_attributes
      get :edit, { id: configuration.to_param }, valid_session
      expect(assigns(:client_configuration)).to eq(configuration)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { version: '2.0' }
      }

      it "updates the requested configuration" do
        client_configuration = ClientConfiguration.create! valid_attributes
        put :update, { id: client_configuration.to_param,  client_configuration: new_attributes}, valid_session
        expect(client_configuration.reload.version).to eq '2.0'
      end

      it "assigns the requested configuration as @configuration" do
        configuration = ClientConfiguration.create! valid_attributes
        put :update, { id: configuration.to_param,  client_configuration: valid_attributes}, valid_session
        expect(assigns(:client_configuration)).to eq(configuration)
      end

      it "redirects to the configuration" do
        configuration = ClientConfiguration.create! valid_attributes
        put :update, { id: configuration.to_param,  client_configuration: valid_attributes}, valid_session
        expect(response).to redirect_to(configuration)
      end
    end

    context "with invalid params" do
      it "assigns the configuration as @configuration" do
        configuration = ClientConfiguration.create! valid_attributes
        put :update, { id: configuration.to_param,  client_configuration: invalid_attributes}, valid_session
        expect(assigns(:client_configuration)).to eq(configuration)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested configuration" do
      client_configuration = ClientConfiguration.create! valid_attributes
      second_client_configuration = ClientConfiguration.create! valid_attributes
      expect {
        delete :destroy, { id: second_client_configuration.to_param }, valid_session
      }.to change(ClientConfiguration, :count).by(-1)
    end

    it "redirects to the configurations list" do
      configuration = ClientConfiguration.create! valid_attributes
      config_group = configuration.configuration_group_id
      delete :destroy, { id: configuration.to_param }, valid_session
      expect(response).to redirect_to(configuration_group_path(configuration.configuration_group_id))
    end
  end

end
