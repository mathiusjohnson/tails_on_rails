Rails.application.routes.draw do
  get 'welcome/index'
  # devise_for :users, :controllers => { :registrations => 'registrations' }
  # devise_for :users
  mount_graphql_devise_for 'User', at: '/api/v1/graphql_auth', operations: {
    login:    Mutations::SignInUser,
    sign_up:  Mutations::CreateUser,
    # register: Mutations::Register
  }, additional_mutations: {
    # register_confirmed_user: Mutations::RegisterConfirmedUser
  }, additional_queries: {
    # public_user: Resolvers::PublicUser
  }

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new", as: "new_session" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
    get "/forgot_password" => "devise/mailer#reset_password_instructions", as: "new_password"
    get "/request_confirmation" => "devise/confirmations#new", as: "new_confirmation"
    get "/unlock" => "devise/unlocks#new", as: "new_unlock"

    get "/unlock" => "devise/unlocks#new", as: "edit_user_registration"
    get "/logout" => "devise/unlocks#new", as: "destroy_user_session"
    post "signup", to: "registrations#create"
  end

  post "/graphql", to: "graphql#execute"
  # post "/signup", to: ""
  root to: "welcome#index"
end
