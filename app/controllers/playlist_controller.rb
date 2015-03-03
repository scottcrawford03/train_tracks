class PlaylistController < ApplicationController
  def show
    
  end

  def create
    redirect_to playlist_path(1)
  end
end
