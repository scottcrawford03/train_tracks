Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['spotify_key'] , ENV['spotify_secret']
end
