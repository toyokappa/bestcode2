Rails.application.routes.draw do
  root "welcome#index"

  namespace :users do
    get "/auth/:provider/callback", to: "sessions#create"
    delete "/sessions", to: "sessions#destroy", as: "sign_out"
    resources :plans, only: %i[new create edit update destroy]
  end

  resources :plans, only: %i[show]
end
