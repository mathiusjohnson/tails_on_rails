class LinksController < ApplicationController
  Client = Graphlient::Client.new('http://localhost:3000/graphql',
    # headers: {
    #   'Authorization' => 'Bearer 123'
    # },
    http_options: {
      read_timeout: 20,
      write_timeout: 30
    }
  )

  Response = Client.query <<~GRAPHQL
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


  def index
    @data = Response.data.all_links
  end

end
