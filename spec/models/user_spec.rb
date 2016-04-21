require 'rails_helper'

RSpec.describe User, :model do
  it{ should validate_presence_of(:username) }
end
