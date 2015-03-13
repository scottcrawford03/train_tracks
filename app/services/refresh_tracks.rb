class RefreshTracks
  def self.do!
    new.do!
  end

  def do!
    playlist_tracks = SpotifyTracks.get_tracks_from_playlists(access_token)
    Track.save_tracks_from_spotify(playlist_tracks)
    update_bpm_for_new_tracks
  end

  def update_bpm_for_new_tracks
    tracks_for_update.each do |track|
      bpm = EchoNestTracks.get_bpm_for(track)
      track.update(avg_bpm: bpm) if bpm
    end
  end

  private

  def access_token
    response = connection.post "/api/token" do |request|
      request.headers = { 'Authorization' => "Basic #{auth_header}" }
      request.body = { grant_type: "refresh_token", refresh_token: admin.refresh_token }
    end
    JSON.parse(response.body).fetch('access_token')
  end

  def admin
    User.find_by!(uid: ENV.fetch('admin_uid'), provider: 'spotify')
  end

  def connection
    Faraday.new url: 'https://accounts.spotify.com'
  end

  def auth_header
    Base64.strict_encode64("#{ENV.fetch('spotify_key')}:#{ENV.fetch('spotify_secret')}")
  end

  def tracks_for_update
    Track.where(avg_bpm: nil).where.not(spotify_track_id: nil)
  end
end
