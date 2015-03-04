class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :intensity
      t.integer :length
      
      t.timestamps null: false
    end
  end
end
