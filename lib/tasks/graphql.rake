# namespace :schema do
#   # The public schema will evolve over time, so you'll want to periodically
#   # refetch the latest and check in the changes.
#   #
#   # An offline copy of the schema allows queries to be typed checked statically
#   # before even sending a request.
#   desc "Update GraphqlTutorial GraphQL schema"
#   task :update do
#     GraphQL::Client.dump_schema(TailsOnRails::HTTPAdapter, "db/schema.json")
#   end
# end

require "graphql/rake_task"
GraphQL::RakeTask.new(schema_name: "GraphqlTutorialSchema")