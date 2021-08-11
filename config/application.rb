require_relative "boot"

require "rails/all"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TailsOnRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end

  Rails.autoloaders.main.ignore(Rails.root.join('app/services'))


  Client = Graphlient::Client.new('http://localhost:3000/graphql',
    # headers: {
    #   'Authorization' => 'Bearer 123'
    # },
    http_options: {
      read_timeout: 20,
      write_timeout: 30
    },
    schema_path: 'db/schema.json'
  )
  
end
