class Api::V1::BaseApiController < ApplicationController
  skip_before_filter :authenticate_user!

  before_filter :authenticate_token!
  before_filter :authorize_write!, except: [:index, :show, :status]

  def status
    render json: { status: 'running', timestamp: Time.now }
  end

  def enroll
  end

  private

    def authenticate_token!
      authenticate_or_request_with_http_token do |token, _|
        ApiKey.exists?(key: token)
      end
    end

    def authorize_write!
      authenticate_or_request_with_http_token do |token, _|
        ApiKey.find_by_key(token).try(:perms).try(:include?, 'read/write')
      end
    end
end
