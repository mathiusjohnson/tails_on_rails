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


  # HTTPAdapter = GraphQL::Client::HTTP.new("http://localhost:3000/graphiql") do
  #   # def headers(context)
  #   #   unless token = context[:access_token] || Application.secrets.github_access_token
  #   #     # $ GITHUB_ACCESS_TOKEN=abc123 bin/rails server
  #   #     #   https://help.github.com/articles/creating-an-access-token-for-command-line-use
  #   #     fail "Missing GitHub access token"
  #   #   end

  #   #   {
  #   #     "Authorization" => "Bearer #{token}"
  #   #   }
  #   # end
  # end

  # Client = GraphQL::Client.new(
  #   schema: Application.root.join("db/schema.json").to_s,
  #   execute: HTTPAdapter
  # )
  # Application.config.graphql.client = Client
end
