class Api::V1::Clients::ConfigurationController < Api::V1::BaseApiController
  before_action :set_client

  def show
    render json: @client.get_config(user_agent: request.user_agent)
  end

  private

    def set_client
      @client = Client.find(params[:client_id])
    end

    def client_configuration_params
      params.require(:client_key)
    end
end
