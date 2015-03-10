class AddPlaylistIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :playlist
    end
  end
end
