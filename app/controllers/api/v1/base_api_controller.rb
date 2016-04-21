class Api::V1::BaseApiController < ApplicationController
  skip_before_filter :authenticate_user!

  def status
    render json: { status: 'running', timestamp: Time.now }
  end

  def enroll

  end
end
