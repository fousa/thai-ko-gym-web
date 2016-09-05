module Api
  class ApplicationController < ::ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :authenticate_request

    attr_reader :current_user

    private

    def authenticate_request
      @current_user = AuthorizeRequest.call(request.headers).result
      render json: { error: 'Not authorized' }, status: 401 unless @current_user
    end
  end
end
