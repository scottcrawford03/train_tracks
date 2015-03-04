class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :spotify_album_url
      t.string :spotify_album_image
      t.string :spotify_album_name

      t.string :spotify_artist_url
      t.string :spotify_artist_name
      t.string :spotify_artist_id

      t.string :spotify_track_url
      t.string :spotify_track_id
      t.string :spotify_track_name

      t.string :track_type
      t.integer :max_bpm
      t.integer :min_bpm
      t.integer :avg_bpm

      t.integer :length
      t.boolean :explicit

      t.timestamps null: false
    end
  end
end
