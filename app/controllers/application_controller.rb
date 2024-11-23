class ApplicationController < ActionController::API
  def render_api(status, message, data = nil)
    render json: {
      message: message,
      data: data,
      status: status
    }, status: status
  end
end
