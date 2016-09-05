require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThaiKoGym
  class Application < Rails::Application
    # Set the default locale.
    config.i18n.default_locale = :nl

    # Make the application handle the exceptions through the routing.
    config.exceptions_app = self.routes

    # Load the library folder by default.
    config.autoload_paths << Rails.root.join('lib')
  end
end
