require 'rails_helper'

RSpec.describe Api::V1::ClientsController, :controller do
  let(:config_group){ create :configuration_group }
  let(:config){ create(:client_configuration, config_json: { test: 'test' }) }
  let(:client){ create(:client, configuration_group: config_group) }

  before do
    config.configuration_group = config_group
    config.save!
    client
  end

  describe 'GET #index' do
    it 'assigns all clients as @clients' do
      get :index, format: :json
      expect(assigns(:clients)).to eq Client.all
    end
  end

  describe 'GET #show' do
    it 'assigns the requested client as @client' do
      get :show, { id: client.to_param, format: :json }
      expect(assigns(:client)).to eq(client)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested client configuration' do
      expect {
        delete :destroy, { id: client.to_param }
      }.to change(Client, :count).by(-1)
    end
  end

end
