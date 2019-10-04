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
    # NOTE: GitHubのnameをUser#nameとして使用しているので一旦問題ないが
    #       自分でnameを変更できるようにする場合、文字種を気をつける必要がある
    resources :messages, only: %i[index create destroy], path: "/:user_name/messages"
    resource :profile, only: %i[edit, update]
  end

  get "/:user_name/profile", to: "profiles#show", as: :profile
  resources :plans, only: %i[show]
end
