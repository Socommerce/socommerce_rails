class Api::V1::BaseController < ApplicationController
  API_REQUEST_FROM="socommerce_api_caller"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :json

  before_filter :validate_api_request_version

  private

  def validate_api_request_version
    verify_request_version || render_invalid_message
  end

  def verify_request_version
    API_REQUEST_FROM == request.headers['Api-Request-From']
  end

  def render_invalid_message
    render_json false, 'Unauthorized call', 403
  end

  def render_json(success, message, status)
    render :json => {:success => success, :response => message}, :status => status
  end
end