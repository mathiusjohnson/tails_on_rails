# module GraphqlManager
  class GetLinks < ApplicationService
    def initialize
    end

    Client = Graphlient::Client.new('http://localhost:3000/graphql',
      # headers: {
      #   'Authorization' => 'Bearer 123'
      # },
      http_options: {
        read_timeout: 20,
        write_timeout: 30
      }
    )

    Links = Client.query <<~GRAPHQL
    query {
      allLinks {
        id
        description
        postedBy {
          firstName
        }
        votes {
          user {
            email
          }
        }
      }
    }
    GRAPHQL

    def call
      @data = Links.data.all_links
    end
  end
# end