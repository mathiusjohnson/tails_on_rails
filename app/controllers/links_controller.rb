class LinksController < ApplicationController

  
  def index
    query_string = <<~GQL
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
    GQL
    
    response = GraphqlTutorialSchema.execute(query: query_string)
    # puts "current user: " + current_user.to_s
    byebug
    @data = response.to_h["data"]["allLinks"]
  end

  def show
    @link = Links.find(params[:id])
  end

end
