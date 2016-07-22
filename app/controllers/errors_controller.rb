class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  layout 'error'

  def show
    @status_code = params[:code] || 500
    render status: @status_code
  end
end
