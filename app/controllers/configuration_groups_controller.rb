class ConfigurationGroupsController < ApplicationController
  before_action :set_configuration_group, only: [:show, :edit, :update, :destroy]

  # GET /configuration_groups
  # GET /configuration_groups.json
  def index
    @configuration_groups = ConfigurationGroup.all
  end

  # GET /configuration_groups/1
  # GET /configuration_groups/1.json
  def show
  end

  # GET /configuration_groups/new
  def new
    @configuration_group = ConfigurationGroup.new
  end

  # GET /configuration_groups/1/edit
  def edit
  end

  # POST /configuration_groups
  # POST /configuration_groups.json
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

  # PATCH/PUT /configuration_groups/1
  # PATCH/PUT /configuration_groups/1.json
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

  # DELETE /configuration_groups/1
  # DELETE /configuration_groups/1.json
  def destroy
    @configuration_group.destroy
    respond_to do |format|
      format.html { redirect_to configuration_groups_url, notice: 'Configuration group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuration_group
      @configuration_group = ConfigurationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def configuration_group_params
      params.fetch(:configuration_group, {})
    end
end
