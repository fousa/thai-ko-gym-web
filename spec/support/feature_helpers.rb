module FeatureHelpers
  def press_enter(selector)
    element = find(selector)
    element.native.send_key(:Enter)
  end

  def attach_csv(title, filename)
    path = File.join(Rails.root, "spec/fixtures/#{filename}.csv")
    attach_file title, path
  end

  def login_as_pilot(pilot = nil)
    @pilot = pilot || create(:pilot, admin: true, first_name: '111111', last_name: '22222', email: '111@2222.be')
    login_as(@pilot, scope: :pilot)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
