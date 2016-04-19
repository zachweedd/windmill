require 'rails_helper'

RSpec.describe ClientConfiguration, :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :version }
  it { should validate_presence_of :config_json }

  it { should have_many(:assigned_clients).class_name('Client') }
  it { should have_many(:configured_clients).class_name('Client') }

  it { should belong_to :configuration_group }

  describe 'custom validations' do
    let(:configuration_group){ create(:configuration_group) }
    let(:client_configuration){ create(:client_configuration, config_json: { test: 'test' }, configuration_group: configuration_group) }

    describe 'on destroy' do
      it 'fails when there are clients present' do
        client_configuration.configuration_group.clients.create(client_key: 'test_key')
        expect{client_configuration.destroy}.to change{ ClientConfiguration.count }.by(0)
      end

      it 'fails when it is the default config group' do
        client_configuration
        expect{client_configuration.destroy}.to change{ ClientConfiguration.count }.by(0)
      end
    end
  end


end
