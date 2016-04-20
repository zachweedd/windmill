require 'rails_helper'

RSpec.describe ConfigurationGroups::ClientConfigurationsController, :controller do
  let(:configuration_group){ create :configuration_group }
  let(:valid_attributes) {
    {
      name: 'test', version: '0.1', config_json: { foo: 'bar' }.to_json
    }
  }

  let(:invalid_attributes) {
    { some_thing: 'some other thing' }
  }

  let(:valid_session) { {} }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ClientConfiguration" do
        expect {
          post :create, { client_configuration: valid_attributes, configuration_group_id: configuration_group.id }, valid_session
        }.to change(ClientConfiguration, :count).by(1)
      end

      it "assigns a newly created client configuration as @client_configuration" do
        post :create, { client_configuration: valid_attributes, configuration_group_id: configuration_group.id }, valid_session
        expect(assigns(:client_configuration)).to be_a(ClientConfiguration)
        expect(assigns(:client_configuration)).to be_persisted
      end

      it "redirects to the client con" do
        post :create, { client_configuration: valid_attributes, configuration_group_id: configuration_group.id }, valid_session
        expect(response).to redirect_to(client_configuration_path(ClientConfiguration.last))
      end
    end
  end

end
