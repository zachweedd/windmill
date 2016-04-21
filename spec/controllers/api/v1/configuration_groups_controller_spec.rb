require 'rails_helper'

RSpec.describe ConfigurationGroupsController, :controller do
  let(:configuration_group){ create :configuration_group }
  let(:configuration){ create(:client_configuration, config_json: { test: 'test' }) }
  let(:configuration_two){ create(:client_configuration, config_json: { test: 'test' }) }

  let(:valid_attributes) {
    { name: 'test group' }
  }

  before do
    configuration_group.configurations << configuration
  end

  describe 'GET #index' do
    it 'assigns all configuration_groups as @configuration_groups' do
      get :index
      expect(assigns(:configuration_groups)).to eq ConfigurationGroup.all
    end
  end

  describe 'GET #show' do
    it 'assigns the requested configuration_group as @configuration_group' do
      get :show, { id: configuration_group.to_param, format: :json }
      expect(assigns(:configuration_group)).to eq(configuration_group)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ConfigurationGroup' do
        expect {
          post :create, { configuration_group: valid_attributes, format: :json }
        }.to change(ConfigurationGroup, :count).by(1)
      end

      it 'assigns a newly created configuration_group as @configuration_group' do
        post :create, { configuration_group: valid_attributes, format: :json }
        expect(assigns(:configuration_group)).to be_a(ConfigurationGroup)
        expect(assigns(:configuration_group)).to be_persisted
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: 'new name' }
      }

      it 'updates the requested configuration_group' do
        put :update, { id: configuration_group.to_param, configuration_group: new_attributes, format: :json }
        expect(configuration_group.reload.name).to eq 'new name'
      end

      it 'assigns the requested configuration_group as @configuration_group' do
        put :update, { id: configuration_group.to_param, configuration_group: new_attributes, format: :json }
        expect(assigns(:configuration_group)).to eq(configuration_group)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested configuration_group' do
      expect {
        delete :destroy, { id: configuration_group.to_param }
      }.to change(ConfigurationGroup, :count).by(-1)
    end
  end

end
