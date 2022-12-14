Rails.application.routes.draw do
  root to: "applications#index"

  namespace :api do
    namespace :v1 do
      resources :endpoints, except: [:show, :edit]
    end
  end
  post "login", to: "api/v1/authentications#login"
  match "*path", to: "api/v1/endpoints#show", via: [:all]

end
