class ConfigurationGroups::ClientConfigurationsController < ApplicationController
  before_action :set_configuration_group

  def create
    @client_configuration = ClientConfiguration.new(full_configuration_params)

    respond_to do |format|
      if @client_configuration.save
        format.html { redirect_to client_configuration_path(@client_configuration), notice: 'Client Configuration was successfully created.' }
        format.json { redirect_to client_configuration_path(@client_configuration), status: :created, location: @configuration }
      else
        format.html { render :new }
        format.json { render json: @client_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @client_configuration = @configuration_group.configurations.new
  end

  private

    def set_configuration_group
      @configuration_group = ConfigurationGroup.find(params[:configuration_group_id])
    end

    def full_configuration_params
      client_configuration_params[:client_configuration].merge(
        client_configuration_params.except(:client_configuration)
      )
    end

    def client_configuration_params
      params.permit(
        :configuration_group_id,
        client_configuration: [:name, :version, :config_json, :notes, :configuration_group_id]
      )
    end

end
