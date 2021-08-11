class LinksController < ApplicationController
  # Client = Graphlient::Client.new('http://localhost:3000/graphql',
  #   # headers: {
  #   #   'Authorization' => 'Bearer 123'
  #   # },
  #   http_options: {
  #     read_timeout: 20,
  #     write_timeout: 30
  #   }
  # )

  Links = TailsOnRails::Client.query <<~GRAPHQL
    query {
      allLinks {
        id
        description
        postedBy {
          first_name
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
    @data = Links.data.all_links
  end

  def show
    @link = Links.find(params[:id])
  end

end
