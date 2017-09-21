class AuthenticateController < ApplicationController
  before_action :authenticate_request!, only: [:profile]

  def login
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: { data: {
        auth_token: command.result
        }
      }
    else
      render json: { data: {
            errors: command.errors
        }
      }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        data: @user

      }, status: :created
    else
      render json: {
        data: {
          errors: errors_hash(@user)
        }
      }
    end
  end

  def profile
    render json: {
      data: @current_user

    },status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
