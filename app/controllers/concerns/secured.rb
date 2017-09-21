module Secured
  extend ActiveSupport::Concern
  attr_reader :current_user

  protected

  def authenticate_request!
    id = auth_token
    @current_user = User.find_by_id(id[:user_id])
    unless @current_user
      raise JWT::VerificationError
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { data: {
      errors: ['Not authorized']
      }
    }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    else
      nil
    end
  end

  def auth_token
    JsonWebToken.decode(http_token)
  end
end
