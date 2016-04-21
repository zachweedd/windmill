class Api::V1::ClientConfigurationsController < Api::V1::BaseApiController
  before_action :set_client_configuration, only: [:show, :update, :destroy]

  def index
    render json: ClientConfiguration.all
  end

  def create
    @configuration_group = ConfigurationGroup.find(params[:configuration_group_id])

    @configuration = @configuration_group.configurations.build({
      name: configuration_params[:name],
      config_json: configuration_params[:config_json],
      version: configuration_params[:version],
      notes: configuration_params[:notes]
    })

    if @configuration.save
      render json: { 'status': 'success', 'config': @configuration }
    else
      { 'status': 'error', 'error': @configuration.errors }
    end
  end

  def show
    render json: {
      id: @configuration.id,
      name: @configuration.name,
      version: @configuration.version,
      notes: @configuration.notes,
      config_json: @configuration.config_json,
      assigned_endpoints: @configuration.assigned_clients.map {|e| e.id},
      assigned_endpoint_count: @configuration.assigned_clients.count,
      configured_endpoints: @configuration.configured_clients.map {|e| e.id},
      configured_endpoint_count: @configuration.configured_clients.count
    }
  end

  def update
    if @config.assigned_clients.any? && configuration_params[:config_json]
      render json: { status: "error", error: "Cannot modify config_json when Configuration has assigned endpoints." }
    else
      if @configuration.update(configuration_params)
        render json: { status: "success", config: @configuration }
      else
        render json: { status: "error", error: @configuration.errors }
      end
    end
  end

  def destroy
    if @configuration.destroy
      render json: { status: 'deleted' }
    else
      render json: { 'status': 'error', error: @configuration.errors }
    end
  end

  private

    def set_client_configuration
      @configuration = ClientConfiguration.find(params[:id])
    end

    def configuration_params
      params.require(:configuration).permit(
        :configuration_group_id, :name, :config_json, :version,
        :notes
      )
    end
end
