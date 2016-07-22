class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to error_403_path
  end
end
