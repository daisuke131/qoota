Rails.application.routes.draw do
  root "home#index"
  get "/sign_in", to: "home#index"
  get "/post/new", to: "home#index"
  get "/post/edit/:id", to: "home#index"
  get "/article/:id", to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :articles
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :users, except: [:create, :destroy]
    end
  end
end