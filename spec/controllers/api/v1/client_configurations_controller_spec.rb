require 'rails_helper'

RSpec.describe Api::V1::ClientConfigurationsController, :controller do
  let(:configuration_group){ create :configuration_group }

  let(:valid_attributes) {
    {
      name: 'test', version: '0.1', notes: 'test', config_json: {one: 'one'}.to_json,
      configuration_group_id: configuration_group.id
    }
  }

  let(:client_configuration){ create :client_configuration, valid_attributes }

  before do
    client_configuration
  end

  describe 'GET #index' do
    it 'assigns all client configurations as @client_configurations' do
      get :index, format: :json
      expect(assigns(:client_configurations)).to eq ClientConfiguration.all
    end
  end

  describe 'GET #show' do
    it 'assigns the requested client configuration as @client_configuration' do
      get :show, { id: client_configuration.to_param, format: :json }
      expect(assigns(:client_configuration)).to eq(client_configuration)
    end
  end

  describe 'POST #create' do
    it 'creates a client_configuration with the passed params' do
      expect do
        post :create, { client_configuration: valid_attributes, format: :json }
      end.to change{ ClientConfiguration.count }.by(1)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { version: '2.0' }
      }

      it 'updates the requested configuration' do
        put :update, { id: client_configuration.to_param,  client_configuration: new_attributes }
        expect(client_configuration.reload.version).to eq '2.0'
      end

      it 'assigns the requested client_configuration as @client_configuration' do
        put :update, { id: client_configuration.to_param,  client_configuration: new_attributes, format: :json }
        expect(assigns(:client_configuration)).to eq(client_configuration)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested client configuration' do
      second_client_configuration = create :client_configuration, valid_attributes
      expect {
        delete :destroy, { id: second_client_configuration.to_param }
      }.to change(ClientConfiguration, :count).by(-1)
    end
  end

end
