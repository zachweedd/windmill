class ClientConfiguration < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :version
  validates_presence_of :config_json
  validate :json_validation

  has_many :assigned_clients, class_name: 'Client', foreign_key: 'assigned_config_id'
  has_many :configured_clients, class_name: 'Client', foreign_key: 'last_config_id'

  belongs_to :configuration_group

  before_destroy :can_destroy?


  private

    def json_validation
      return true if self.config_json.is_a? Hash

      begin
        JSON.parse!(self.config_json)
      rescue JSON::ParserError, TypeError
        errors.add(:config_json, 'Not parsable JSON')
      end
      true
    end

    def can_destroy?
      validate_assigned_clients
      validate_default_config
      errors.empty?
    end

    def validate_assigned_clients
      if self.assigned_clients.any?
        errors.add(:base, 'Cannot delete configuration while it has assigned endpoints')
      end
    end

    def validate_default_config
      if self.configuration_group.default_config == self
        errors.add(:base, 'Cannot delete the default configuration for a configuration group')
      end
    end
end
