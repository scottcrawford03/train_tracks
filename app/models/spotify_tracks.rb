class SpotifyTracks
  def self.service(token)
    @service ||= SpotifyService.new(token)
  end

  def self.get_tracks_from_playlists(token)
    playlists = service(token).top_playlists
    get_tracks(token, playlists)
  end

  def self.find_tracks_of_playlist(token, tracks)
    service(token).playlist_tracks(tracks)
  end

  def self.find_top_playlists(token)
    service(token).top_playlists
  end

  def self.get_tracks(token, playlists)
    playlists['playlists']['items'].map do |playlist|
      tracks_call = URI.parse(playlist['tracks']['href']).path
      find_tracks_of_playlist(token, tracks_call)
    end
  end
end
