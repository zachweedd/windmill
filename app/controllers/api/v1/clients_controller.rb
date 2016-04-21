class Api::V1::ClientsController < Api::V1::BaseApiController
  before_action :set_client, only: [:show, :destroy]

  def index
    @clients = Client.all
  end

  def create
    # Comment and code below copied from Sinatra App -- following instructions :)
    # Not implemented deliberately. Should be registered by osquery.
    render json: {'status': 'endpoint creation via the Windmill API is not supported'}
  end

  def show
  end

  def update
    # Comment and code below copied from Sinatra App -- following instructions :)
    # Not implemented deliberately. Should be updated by osquery.
    render json: { 'status': 'endpoint updating via the Windmill API is not supported' }
  end

  def destroy
    if @client.destroy
      render json: { 'status': 'deleted' }
    else
      render json: { 'status': 'error', errors: @client.errors }
    end
  end

  private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(
        :client_key, :config_count, :last_ip,
        :last_config_time, :identifier, :group_label, :assigned_config_id,
        :configuration_group_id
      )
    end
end
