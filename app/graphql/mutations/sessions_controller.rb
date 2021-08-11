class SessionsController < GraphqlController
  # before_action :logged_in_redirect, only: [:new, :create]

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

    byebug
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
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end

end
