class ClientConfigurationsController < ApplicationController
  before_action :set_client_configuration, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @client_configuration.update(client_configuration_params)
        format.html { redirect_to @client_configuration, notice: 'Client Configuration was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_configuration }
      else
        format.html { render :edit }
        format.json { render json: @client_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client_configuration.destroy
    respond_to do |format|
      format.html { redirect_to configuration_group_path(@client_configuration.configuration_group), notice: 'Client Configuration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    def set_client_configuration
      @client_configuration = ClientConfiguration.find(params[:id])
    end

    def client_configuration_params
      params.require(:client_configuration).permit(:name, :version, :notes, :config_json)
    end
end
