Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'sessions#index'
  delete '/logout', to: 'sessions#destroy'
  resources :playlist
end
