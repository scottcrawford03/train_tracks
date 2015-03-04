class CreatePlaylistTracks < ActiveRecord::Migration
  def change
    create_table :playlists_tracks do |t|
      t.references :playlist, index: true
      t.references :track, index: true
    end
    add_foreign_key :playlists_tracks, :playlists
    add_foreign_key :playlists_tracks, :tracks
  end
end
