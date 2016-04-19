require 'rails_helper'

RSpec.describe ConfigurationGroup, :model do
  let(:configuration_group){ create :configuration_group }
  let(:configuration){ create(:client_configuration, config_json: { test: 'test' }) }
  let(:configuration_two){ create(:client_configuration, config_json: { test: 'test' }) }

  it{ should validate_presence_of(:name) }

  it{ should have_many(:clients) }
  it{ should have_many(:configurations) }

  describe 'callbacks' do
    before do
      configuration_group.configurations << configuration
    end

    describe 'before_destroy' do
      context 'when the configuration group has clients' do
        it 'does not destroy' do
          configuration_group.clients.create(client_key: 'test')
          expect{configuration_group.destroy}.to change{ ConfigurationGroup.count }.by(0)
        end
      end

      context 'when the configuration group is a default group' do
        it 'does not destroy' do
          configuration_group.update(name: 'default')
          expect{configuration_group.destroy}.to change{ ConfigurationGroup.count }.by(0)
        end
      end
    end
  end

  describe '#default_config' do
    context 'when there is no default_config' do
      it 'returns the first configuration' do
        configuration_group.configurations << configuration
        configuration_group.save!
        expect(configuration_group.default_config).to eq configuration
      end
    end

    it 'allows assignment' do
      configuration_group.default_config = configuration
      configuration_group.save!
      expect(configuration_group.default_config).to eq configuration
    end
  end

  context 'canary' do
    it 'allows assignment to a configuration' do
      configuration_group.canary_config = configuration
      configuration_group.save!
      expect(configuration_group.canary_config).to eq configuration
    end

    it 'prevents assignment if a deployment is in progress' do
      configuration_group.canary_config = configuration
      expect{configuration_group.canary_config = configuration }.to raise_error(RuntimeError)
      expect(configuration_group.canary_config).to eq(configuration)
    end

    describe '#cancel_canary' do
      it 'cancels the canary deployment and reverts changes' do
        configuration_group.configurations << configuration
        configuration_group.configurations << configuration_two

        client = configuration_group.clients.create(client_key: 'test')

        configuration_group.canary_config = configuration_two
        configuration_group.assign_config_percent(configuration_two, 100)
        configuration_group.cancel_canary

        expect(configuration_group.canary_in_progress?).to be_falsey
        expect(client.reload.assigned_config).to eq(configuration)
      end

      it 'fails when a canary is already in progress' do
        configuration_group.canary_config = configuration_two
        expect{ configuration_group.canary_config = configuration }.to raise_error(RuntimeError)
        expect(configuration_group.canary_in_progress?).to be_truthy
      end
    end

    describe '#promote_canary' do
      it 'promotes a canary to default and refreshese all endpoints' do
        configuration_group.configurations << configuration
        configuration_group.configurations << configuration_two

        client = configuration_group.clients.create(client_key: 'test')

        configuration_group.canary_config = configuration_two
        configuration_group.promote_canary
        client.reload
        expect(configuration_group.canary_in_progress?).to be_falsey
        expect(configuration_group.default_config).to eq(configuration_two)
        expect(client.assigned_config).to eq configuration_two
      end

      it 'fails when a canary is not in progress' do
        expect{configuration_group.promote_canary}.to raise_error{RuntimeError}
      end
    end

    describe '#canary_in_progress?' do
      it 'indicates if a canary deployment is in progress' do
        expect(configuration_group.canary_in_progress?).to be_falsey
        configuration_group.canary_config = configuration
        expect(configuration_group.canary_in_progress?).to be_truthy
      end
    end
  end
end
