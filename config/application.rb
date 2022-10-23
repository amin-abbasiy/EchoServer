require_relative "boot"
require_relative '../lib/request_validator'
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

::Dotenv::Railtie.load if %w(development test).include? ENV.fetch('RAILS_ENV', 'development')

module EchoServer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.autoload_paths += %W( lib/ controllers/)

    # add middleware
    # config.middleware.use RequestValidator

    # Configuration for the application, engines, and railties goes here.
    #
    #  These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

  end
end
