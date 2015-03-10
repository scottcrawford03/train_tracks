Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'sessions#index'
  delete '/logout', to: 'sessions#destroy'
  resources :playlist
  get '/:user/dashboard', to: 'user#show', as: 'user'
  get "/random_playlist" => "playlist#random", as: 'random_playlist'
  get '/:user/playlists' => "user#playlists", as: 'user_playlists'
end
