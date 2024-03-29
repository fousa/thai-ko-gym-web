module FeatureHelpers
  def press_enter(selector)
    element = find(selector)
    element.native.send_key(:Enter)
  end

  def login_as_user(user = nil)
    @user = user || create(:user_with_password)
    login_as(@user, scope: :user)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
