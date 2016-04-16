class Client < ActiveRecord::Base

  validates_presence_of :client_key
  validates_presence_of :assigned_config_id

  belongs_to :assigned_config, class_name: 'Configuration', foreign_key: 'assigned_config_id'
  belongs_to :last_config, class_name: 'Configuration', foreign_key: 'last_config_id'
  belongs_to :configuration_group

  after_initialize :assign_default_config

  private

    def assign_default_config
      self.config_count = self.config_count.to_i
      if self.assigned_config_id.nil?
        self.assigned_config = self.configuration_group.default_config
      end
    end
end
