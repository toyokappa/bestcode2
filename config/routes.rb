Rails.application.routes.draw do
  namespace :users do
    get '/auth/:provider/callback', to: 'sessions#create'
    delete '/sessions', to: 'sessions#destroy', as: 'sign_out'
  end
end
