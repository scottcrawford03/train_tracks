class PlaylistController < ApplicationController
  before_action :check_for_user, only: [:update]

  def show
    @playlist = Playlist.find(params[:id])
  end

  def create
    playlist_creator = PlaylistCreator.new(playlist_params)
    if playlist_creator.create_playlist
      redirect_to playlist_path(playlist_creator.playlist)
    else
      redirect_to root_path, flash: {errors: playlist_creator.errors}
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

  def spotify
    playlist = Playlist.find(params['id'])
    SpotifyTracks.create_playlist(current_user.token, current_user.uid, playlist)
    playlist.update(saved_to_spotify: true)
    flash[:success] = "Playlist Saved to Spotify. Get to Jammin'"
    redirect_to playlist
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
