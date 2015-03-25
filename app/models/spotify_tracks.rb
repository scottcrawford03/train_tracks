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

  def self.create_playlist(token, user_uid, playlist)
    playlist_url = service(token).create_playlist(user_uid, playlist.name)
    track_ids = playlist.get_track_ids.split(',').map {|id| URI.encode_www_form_component("spotify:track:#{id}") }.join(',')
    service(token).add_tracks_to_playlist(playlist_url, track_ids)
  end

  def self.get_tracks(token, playlists)
    playlists['playlists']['items'].map do |playlist|
      tracks_call = URI.parse(playlist['tracks']['href']).path
      find_tracks_of_playlist(token, tracks_call)
    end
  end
end
