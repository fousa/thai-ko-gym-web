module RequestHelpers
  def add_authentication_header(email, password)
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
    @request.env['HTTP_AUTHORIZATION'] = credentials
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :controller
end
