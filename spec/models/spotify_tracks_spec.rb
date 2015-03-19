RSpec.describe SpotifyTracks, type: :model do
  describe 'spotify api' do
    context 'get the shiz from spotify bro' do
      it "gets the top playlists" do
        VCR.use_cassette('spotify_service_top_playlists') do
          playlists = SpotifyTracks.find_top_playlists('token')
          playlist = playlists['playlists']['items'].first

          expect(playlist['name']).to eq('Peaceful Indie Ambient')
          expect(playlist['tracks']['total']).to eq(75)
        end
      end

      it "gets the tracks from a playlist" do
        VCR.use_cassette('spotify_service_playlist_tracks') do
          tracks = SpotifyTracks.find_tracks_of_playlist('token','v1/users/spotify/playlists/0lBxkSj5VzRfcy8gxFUB5E/tracks')
          track  = tracks['items'][0]['track']

          expect(tracks['items'].count).to eq(75)
          expect(track['name']).to eq("In The Morning")
          expect(track['artists'][0]['name']).to eq("Keaton Henson")
        end
      end

      it "calls the methods that we tested" do
        expect_any_instance_of(SpotifyService).to receive(:top_playlists)
        expect(SpotifyTracks).to receive(:get_tracks)
        SpotifyTracks.get_tracks_from_playlists('token')
      end

      it "gets the tracks" do
        VCR.use_cassette('spotify_service_top_playlists') do
          playlists = SpotifyTracks.find_top_playlists('token')

          expect_any_instance_of(SpotifyService).to receive(:playlist_tracks).exactly(12).times
          SpotifyTracks.get_tracks('token', playlists)
        end
      end

    end
  end
end
