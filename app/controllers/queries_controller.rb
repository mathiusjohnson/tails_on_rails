def QueriesController < ApplicationController

  Client = Graphlient::Client.new('http://localhost:3000/graphql',
    # headers: {
    #   'Authorization' => 'Bearer 123'
    # },
    http_options: {
      read_timeout: 20,
      write_timeout: 30
    }
  )

  def all_links
    @links = Client.query <<~GRAPHQL
      query {
        allLinks {
          id
          description
          postedBy {
            name
          }
          votes {
            user {
              email
            }
          }
        }
      }
    GRAPHQL
  end
  
end