class ApiKey < ActiveRecord::Base
  PERMS = %w( read read/write )

  validates_presence_of :perms

  before_create :generate_random_key

  private

    def generate_random_key
      self.key = SecureRandom.hex(32)
    end
end
