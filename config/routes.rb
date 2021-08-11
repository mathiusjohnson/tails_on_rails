Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]  

  get 'welcome/index'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  get "/links" => "links#index"
  get "/sign_up" => "registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get "/forgot_password" => "devise/mailer#reset_password_instructions", as: "new_password"
  get "/request_confirmation" => "devise/confirmations#new", as: "new_confirmation"
  get "/unlock" => "devise/unlocks#new", as: "new_unlock"

  get "/unlock" => "devise/unlocks#new", as: "edit_user_registration"
  get "/logout" => "devise/unlocks#new", as: "destroy_user_session"
  post "signup", to: "registrations#create"

  post "/graphql", to: "graphql#execute"
  # post "/signup", to: ""
  root to: "welcome#index"
end
