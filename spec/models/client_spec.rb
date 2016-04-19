require 'rails_helper'

RSpec.describe Client, :model do
  let(:config_group){ create :configuration_group }
  let(:config){ create(:client_configuration, config_json: { test: 'test' }) }
  let(:client){ create(:client, configuration_group: config_group) }

  before do
    config_group.configurations << config
  end

  it{ should validate_presence_of :client_key }

  describe 'callbacks' do
    describe '#assign_default_config' do
      it 'assigns a default config to the client' do
        expect(client.assigned_config).to eq config_group.default_config
      end
    end
  end

  describe '#get_config' do
    it 'returns the config_json for the client' do
      expect(client.get_config).to eq({"test" => 'test'})
    end
  end
end
