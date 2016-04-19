class ConfigurationGroups::ClientConfigurationsController < ApplicationController
  before_action :set_configuration, only: [:show, :edit, :update, :destroy]

  def index
    @configurations = ConfigurationGroup.find(params[:configuration_group_id]).configurations
  end

  def show
  end

  def new
    @configuration = ClientConfiguration.new(params)
  end

  def edit
  end

  def create
    @configuration = ClientConfiguration.new(configuration_params)

    respond_to do |format|
      if @configuration.save
        format.html { redirect_to @configuration, notice: 'Client Configuration was successfully created.' }
        format.json { render :show, status: :created, location: @configuration }
      else
        format.html { render :new }
        format.json { render json: @configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @configuration.update(configuration_params)
        format.html { redirect_to @configuration, notice: 'Client Configuration was successfully updated.' }
        format.json { render :show, status: :ok, location: @configuration }
      else
        format.html { render :edit }
        format.json { render json: @configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @configuration.destroy
    respond_to do |format|
      format.html { redirect_to configurations_url, notice: 'Client Configuration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_configuration
      @configuration = ClientConfiguration.find(params[:id])
    end

end
