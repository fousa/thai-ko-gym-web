module Api
  class ApplicationController < ::ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_request

    attr_reader :current_user

    rescue_from CanCan::AccessDenied do
      respond_to do |format|
        format.json { render nothing: true, status: :forbidden }
      end
    end

    private

    def authenticate_request
      @current_user = AuthorizeRequest.call(request.headers).result
      render json: { error: 'Not authorized' }, status: 401 unless @current_user
    end
  end
end
