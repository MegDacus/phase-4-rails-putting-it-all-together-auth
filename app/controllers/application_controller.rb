class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  before_action :authorize

  def unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end

  def authorize
    return render json: {errors:["Not authorized"]}, status: :unauthorized unless session[:user_id]
  end
end
