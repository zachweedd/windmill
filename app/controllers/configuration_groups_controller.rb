class ConfigurationGroupsController < ApplicationController
  before_action :set_configuration_group, only: [:show, :edit, :update, :destroy]

  def index
    @configuration_groups = ConfigurationGroup.all
  end

  def show
    @clients = @configuration_group.clients
  end

  def new
    @configuration_group = ConfigurationGroup.new
  end

  def edit
  end

  def create
    @configuration_group = ConfigurationGroup.new(configuration_group_params)

    respond_to do |format|
      if @configuration_group.save
        format.html { redirect_to @configuration_group, notice: 'Configuration group was successfully created.' }
        format.json { render :show, status: :created, location: @configuration_group }
      else
        format.html { render :new }
        format.json { render json: @configuration_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @configuration_group.update(configuration_group_params)
        format.html { redirect_to @configuration_group, notice: 'Configuration group was successfully updated.' }
        format.json { render :show, status: :ok, location: @configuration_group }
      else
        format.html { render :edit }
        format.json { render json: @configuration_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @configuration_group.destroy
    respond_to do |format|
      format.html { redirect_to configuration_groups_url, notice: 'Configuration group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_configuration_group
      @configuration_group = ConfigurationGroup.find(params[:id])
    end


    def configuration_group_params
      params.require(:configuration_group).permit(:name)
    end
end
