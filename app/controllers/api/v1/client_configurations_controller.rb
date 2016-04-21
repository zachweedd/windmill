class Api::V1::ClientConfigurationsController < Api::V1::BaseApiController
  before_action :set_client_configuration, only: [:show, :update, :destroy]

  def index
    @client_configurations = ClientConfiguration.all
  end

  def create
    @configuration_group = ConfigurationGroup.find(configuration_params[:configuration_group_id])

    @client_configuration = @configuration_group.configurations.build({
      name: configuration_params[:name],
      config_json: configuration_params[:config_json],
      version: configuration_params[:version],
      notes: configuration_params[:notes]
    })

    if @client_configuration.save
      render :show
    else
      render json: { 'status': 'error', 'error': @client_configuration.errors }
    end
  end

  def show
  end

  def update
    if @client_configuration.assigned_clients.any? && configuration_params[:config_json]
      render json: { status: "error", error: "Cannot modify config_json when Configuration has assigned endpoints." }
    else
      if @client_configuration.update(configuration_params)
        render json: { status: "success", client_configuration: @client_configuration }
      else
        render json: { status: "error", error: @client_configuration.errors }
      end
    end
  end

  def destroy
    if @client_configuration.destroy
      render json: { status: 'deleted' }
    else
      render json: { 'status': 'error', error: @client_configuration.errors }
    end
  end

  private

    def set_client_configuration
      @client_configuration = ClientConfiguration.find(params[:id])
    end

    def configuration_params
      params.require(:client_configuration).permit(
        :configuration_group_id, :name, :config_json, :version,
        :notes
      )
    end
end
