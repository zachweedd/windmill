require 'rails_helper'

RSpec.describe Client, :model, focus: true do
  let(:config_group){ create :configuration_group }
  let(:config){ create(:configuration, config_json: { test: 'test' }) }
  let(:client){ create(:client, configuration_group: config_group, assigned_config: config) }

  before do
    config_group.configurations << config
  end

  it{ should validate_presence_of :client_key }
  it{ should validate_presence_of :assigned_config_id }

  describe '#get_config' do
    it 'returns the config_json for the client' do
      expect(client.get_config).to eq({"test" => 'test'})
    end
  end
end
