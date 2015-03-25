class AddSavedToSpotifyToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :saved_to_spotify, :boolean, default: false
  end
end
