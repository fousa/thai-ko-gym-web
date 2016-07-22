require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThaiKoGym
  class Application < Rails::Application
    config.i18n.default_locale = :nl

    config.exceptions_app = self.routes
  end
end
