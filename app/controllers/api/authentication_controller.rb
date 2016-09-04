class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate_request

  def create
    command = AuthenticateUser.call(request)
    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
