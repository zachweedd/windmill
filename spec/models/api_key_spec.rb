require 'rails_helper'

RSpec.describe ApiKey, :model do
  it { should validate_presence_of :perms }

  describe 'callbacks' do
    describe 'before_create' do

      it 'assigns a default key' do
        api_key = create(:api_key, key: nil)
        expect(api_key.reload.key).to_not be_nil
      end

    end
  end
end
