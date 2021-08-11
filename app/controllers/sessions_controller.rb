class SessionsController < ApplicationController
  def new
  end

  def create
    query_string = <<~GQL
      mutation {
        signinUser(
            credentials: {
              email:"add@j.com", 
              password: "123456"
            }
          ) {
          token
          user {
            id
          }
        }
      }
    GQL

    response = GraphqlTutorialSchema.execute(query: query_string)

    token = response.to_h["data"]["signinUser"]["token"]
    session[:token] = token

    # byebug
    # user = User.find_by(username: params[:session][:username])
    # if user && user.authenticate(params[:session][:password])
    #   session[:user_id] = user.id
    #   flash[:success] = "You have successfully logged in"
    #   redirect_to root_path
    # else
    #   flash.now[:error] = "There was something wrong with your login information"
    #   render 'new'
    # end
  end

  def destroy
  end
end
