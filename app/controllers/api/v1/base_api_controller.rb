class Api::V1::BaseApiController < ApplicationController

  def status
    render json: { status: 'running', timestamp: Time.now }
  end

  def enroll

  end
end
