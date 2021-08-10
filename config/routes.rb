Rails.application.routes.draw do
  get 'welcome/index'
  # devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_for :users
  mount_graphql_devise_for 'User', at: '/api/v1/graphql_auth', operations: {
    login:    Mutations::SignInUser,
    sign_up:  Mutations::CreateUser,
    # register: Mutations::Register
  }, additional_mutations: {
    # register_confirmed_user: Mutations::RegisterConfirmedUser
  }, additional_queries: {
    # public_user: Resolvers::PublicUser
  }

  # mount_graphql_devise_for(
  #   Admin,
  #   authenticatable_type: Types::CustomAdminType,
  #   skip:                 [:sign_up, :register, :check_password_token],
  #   operations:           {
  #     confirm_account:            Resolvers::ConfirmAdminAccount,
  #     update_password_with_token: Mutations::ResetAdminPasswordWithToken
  #   },
  #   at:                   '/api/v1/admin/graphql_auth'
  # )

  # mount_graphql_devise_for(
  #   'Guest',
  #   only: [:login, :logout, :sign_up, :register],
  #   at:   '/api/v1/guest/graphql_auth'
  # )

  # mount_graphql_devise_for(
  #   'Users::Customer',
  #   only: [:login],
  #   at:   '/api/v1/user_customer/graphql_auth'
  # )

  get '/api/v1/graphql', to: 'graphql#graphql'
  post '/api/v1/graphql', to: 'graphql#graphql'
  post '/api/v1/interpreter', to: 'graphql#interpreter'
  post '/api/v1/failing', to: 'graphql#failing_resource_name'
  post '/api/v1/controller_auth', to: 'graphql#controller_auth'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "registration" # custom path to sign_up/registration
    # get "/forgot_password" => "devise/mailer#reset_password_instructions", as: "new_password"
    # get "/request_confirmation" => "devise/confirmations#new", as: "new_confirmation"
    # get "/unlock" => "devise/unlocks#new", as: "new_unlock"

    # get "/unlock" => "devise/unlocks#new", as: "edit_user_registration"
    # get "/logout" => "devise/unlocks#new", as: "destroy_user_session"

  end

  post "/graphql", to: "graphql#execute"

  root to: "welcome#index"
end
