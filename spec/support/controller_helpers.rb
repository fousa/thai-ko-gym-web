module ControllerHelpers
  def sign_in(user = double(:user))
    @user = user
    allow(request.env['warden']).to receive(:authenticate!) { user }
    allow(controller).to receive(:current_user) { user }
  end

  def redirect_for_login(&_block)
    yield
    redirect_to(new_user_session_path)
  end

  def redirect_to_path(path, &_block)
    yield
    redirect_to(path)
  end

  def render_template_name(template_name, &_block)
    yield
    render_template template_name
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end
