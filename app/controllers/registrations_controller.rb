# frozen_string_literal: true

class RegistrationsController < ApplicationController


  SignupMutation = TailsOnRails::Client.query <<~GRAPHQL
    mutation {
      createUser(firstName: "'test'", authProvider: {
          credentials: {
            email: "'test@test.ca'", 
            password: "'password'"
          }
        }
      )
    }
  GRAPHQL

  # POST /resource
  def create   
    email = params[:session][:email]
    password = params[:session][:password]

    data = SignUpMutation
    respond_to do |format|
      # format.json { render :json => response }
    end

  end

end
