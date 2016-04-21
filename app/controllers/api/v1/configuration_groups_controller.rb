class Api::V1::ConfigurationGroupsController < Api::V1::BaseApiController
  before_action :set_configuration_group, only: [:show, :edit, :update, :destroy]

  def index
    @configuration_groups = ConfigurationGroup.all
  end

  def show
  end

  def create
    @configuration_group = ConfigurationGroup.new(configuration_group_params)

    if @configuration_group.save
      render :show
    else
      render json: { status: 'error', errors: @configuration_group.errors }
    end
  end

  def update
    if @configuration_group.update(configuration_group_params)
      render :show
    else
      render json: { status: 'error', errors: @configuration_group.errors }
    end
  end

  def destroy
    if @configuration_group.destroy
      render json: { status: 'deleted' }
    else
      render json: { status: :error, errors: @configuration_group.errors }
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
