# frozen_string_literal: true

class RegistrationsController < ApplicationController



  

  # POST /resource
  def create   
    email = params[:session][:email].to_s
    password = params[:session][:password].to_s

    query_string = <<~GQL
      mutation {
        createUser(
          firstName: "mathius", 
          authProvider: {
            credentials: {
              email: "#{email}", 
              password: "#{password}"
            }
          }
        ) {
          email
          
        }
      }
    GQL

    # query_string = <<~GQL
    #   mutation($first_name: string, $auth_provider: AuthProviderSignupData) {
    #     createUser(
    #       firstName: $first_name, 
    #       authProvider: {
    #         $auth_provider
    #       }
    #     ) {
    #       email 
    #     }
    #   }
    # GQL

    # variables = {
    # "firstName" => email,
    # "authParams" => {
    #   "credentials" => {
    #     "email" => email,
    #     "password" => password
    #   }
    # },
    # }


    response = GraphqlTutorialSchema.execute(query: query_string)

    byebug
    respond_to do |format|
      format.json { render :json => response }
      format.html do
        redirect_to '/'
      end
    end

  end

end


# query_string = <<~GQL
# mutation($first_name: string, $auth_provider: AuthProviderSignupData) {
#   createUser(
#     firstName: $first_name, 
#     authProvider: {
#       $auth_provider
#     }
#   ) {
#     email 
#   }
# }
# GQL

# variables = {
# "firstName" => email,
# "authParams" => {
#   "credentials" => {
#     "email" => email,
#     "password" => password
#   }
# },
# }