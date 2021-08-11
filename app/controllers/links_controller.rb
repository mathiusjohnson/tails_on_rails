class LinksController < ApplicationController

  Links = TailsOnRails::Client.query <<~GRAPHQL
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
  
  def index
    @data = Links.data.all_links
  end

  def show
    @link = Links.find(params[:id])
  end

end
