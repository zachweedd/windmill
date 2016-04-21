module Windmill
  class Enroller

    def initialize(params)
      @configuration_group = ConfigurationGroup.find_by(params.fetch(:group_label))
      @identifier = params.fetch(:identifier)
      @enroll_secret = validate_secret(params.fetch(:enroll_secret))
    end

    def enroll
      @configuration_group.clients.create({
        assigned_config_id: @configuration_group.default_config,
        client_key: SecureRandom.uuid,
        config_count: 0,
        group_label: @group_label,
        identifier: @identifier
      })
    end

    private

      def validate_secret(secret)
        fail 'Invalid enroll secret' unless secret == ::NODE_ENROLL_SECRET
      end

  end
end
