class PlaylistCreator < Struct.new(:playlist_params)
  def playlist
    @playlist ||= Playlist.new(playlist_params)
  end

  def create_playlist
    if playlist.save
      tracks = Track.track_intensity(playlist_params[:intensity])
      playlist.create_mix(tracks, playlist_params[:length])
      true
    end
  end

  def errors
    playlist.errors.full_messages.uniq
  end
end
