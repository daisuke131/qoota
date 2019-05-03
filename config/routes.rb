Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :articles
    end
  end
end