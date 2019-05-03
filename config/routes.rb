Rails.application.routes.draw do

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :articles
    end
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }
    end
  end
end