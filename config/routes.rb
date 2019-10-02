Rails.application.routes.draw do
  root "welcome#index"

  namespace :users do
    get "/auth/:provider/callback", to: "sessions#create"
    delete "/sessions", to: "sessions#destroy", as: "sign_out"
    resource :plan, only: %i[new create edit update destroy]
    resources :courses, only: [] do
      resource :contract, only: %i[create destroy]
    end
    resources :mentees, only: %i[index]
    resources :mentors, only: %i[index]
    resource :message_box, only: %i[show]
    resources :messages, only: %i[index create destroy], path: "/:user_name/messages"
  end

  resources :plans, only: %i[show]
end
