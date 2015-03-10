class AddUserIdToPlaylists < ActiveRecord::Migration
  def change
    change_table :playlists do |t|
      t.references :user
    end
  end
end
