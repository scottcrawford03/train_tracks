Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['spotify_key'] , ENV['spotify_secret'], scope: 'playlist-read-private user-read-email playlist-modify-public playlist-modify-private'
end
