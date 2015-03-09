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

  def update
    if current_user
      playlist = Playlist.find(params[:id])
      playlist.user_id = current_user.id
      playlist.name = "#{current_user.name}'s #{playlist.intensity} Intensity Playlist"
      playlist.save
    end
      flash[:success] = "Playlist Saved Successfully"
      redirect_to playlist_path(playlist)
  end

  def random
    if Playlist.count > 0
      offset = rand(Playlist.count)
      playlist = Playlist.offset(offset).first
      redirect_to playlist
    else
      redirect_to root_path
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:intensity, :length)
  end
end
