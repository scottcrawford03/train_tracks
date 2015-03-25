Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'sessions#index'
  delete '/logout', to: 'sessions#destroy'
  resources :playlist do
    post :spotify, on: :member
  end
  
  get '/:user/dashboard', to: 'user#show', as: 'user'
  get "/random_playlist" => "playlist#random", as: 'random_playlist'
  get '/:user/playlists' => "user#playlists", as: 'user_playlists'
  resources :spotify
end
