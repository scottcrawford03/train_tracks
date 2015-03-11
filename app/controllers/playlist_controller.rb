class PlaylistController < ApplicationController
  before_action :check_for_user, only: [:update]

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
    @playlist = Playlist.find(params[:id])
    if params[:name].empty?
      flash[:error] = "Please Name Your Playlist"
    else
      update_playlist
      flash[:success] = "Playlist Saved Successfully"
    end
    redirect_to playlist_path(@playlist)
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

  def update_playlist
    @playlist.user_id = current_user.id
    @playlist.name = params[:name]
    @playlist.save
  end

  def playlist_params
    params.require(:playlist).permit(:intensity, :length)
  end
end
