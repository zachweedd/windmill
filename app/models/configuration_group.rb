class ConfigurationGroup < ActiveRecord::Base
  validates_presence_of :name

  has_many :configurations, class_name: 'ClientConfiguration'
  has_many :clients

  before_destroy :can_destroy?

  def default_config
    ClientConfiguration.where(id: self.default_config_id || self.configurations.first.id).try(:last)
  end

  def default_config=(in_config)
    self.default_config_id = in_config.id
  end

  def canary_config
    ClientConfiguration.where(id: self.canary_config_id).try(:last)
  end

  def canary_config=(in_config)
    raise "Canary currently in progress. Cancel existing canary before setting a canary" if self.canary_in_progress?
    self.canary_config_id = in_config.id
    self.save
  end

  def canary_in_progress?
    !!self.canary_config_id
  end

  def cancel_canary
    self.assign_config_percent(self.default_config, 100)
    self.canary_config_id = nil
    self.save
  end

  def promote_canary
    raise "No canary in progress. Cannot promote what doesn't exist." if !self.canary_in_progress?
    self.assign_config_percent(self.canary_config, 100)
    self.default_config = self.canary_config
    self.canary_config_id = nil
    self.save
  end

  def assign_config_percent(config, in_percent)
    begin
      if in_percent.to_i > 100
        return false
      end
      if in_percent.to_i <= 0
        return false
      end
    rescue
      return false
    end
    if !self.configurations.include?(config)
      return false
    end

    total_assignment_count = (self.clients.count * in_percent / 100.0).to_i
    self.assign_config_count(config, total_assignment_count)
  end

  def assign_config_count(config, in_count)
    number_todo = [in_count, self.clients.count].min

    # Here are the clients that already have the config being assigned
    already_done = self.clients.where(assigned_config_id: config.id).count

    number_todo = number_todo - already_done

    # Shuffle the rest of the clients
    remaining = self.clients.where.not(assigned_config_id: config.id).shuffle

    # now get the front of the whole list and assign configurations
    remaining[0,number_todo].each do |e|
      e.assigned_config = config
      e.save
    end
    true
  end

  private

    def can_destroy?
      validate_not_default_group
      validate_no_clients
      errors.empty?
    end

    def validate_not_default_group
      if self.name == "default"
        errors.add(:base, 'Cannot delete the default configuration group')
      end
    end

    def validate_no_clients
      if self.clients.any?
        errors.add(:base, 'Cannot delete ConfigurationGroup while it has clients')
      end
    end

end
