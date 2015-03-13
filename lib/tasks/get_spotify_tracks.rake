namespace :spotify do
  desc "Get Tracks from Spotify"
  task :get_tracks => [:environment] do
    RefreshTracks.do!
    puts "Got the Tracks"
  end
end
