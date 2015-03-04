class PlaylistController < ApplicationController
  def show
    @playlist = Playlist.find(params[:id])
  end

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      tracks = Track.track_intensity(params[:playlist][:intensity])
      playlist.create_mix(tracks, params[:playlist][:length])
      redirect_to playlist_path(playlist)
    else
      flash[:errors] = playlist.errors.full_messages.uniq.join("<br>")
      redirect_to root_path
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:intensity, :length)
  end
end
