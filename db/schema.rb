# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150312213225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.string   "intensity"
    t.integer  "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "playlists_tracks", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "track_id"
  end

  add_index "playlists_tracks", ["playlist_id"], name: "index_playlists_tracks_on_playlist_id", using: :btree
  add_index "playlists_tracks", ["track_id"], name: "index_playlists_tracks_on_track_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "spotify_album_url"
    t.string   "spotify_album_image"
    t.string   "spotify_album_name"
    t.string   "spotify_artist_url"
    t.string   "spotify_artist_name"
    t.string   "spotify_artist_id"
    t.string   "spotify_track_url"
    t.string   "spotify_track_id"
    t.string   "spotify_track_name"
    t.string   "track_type"
    t.integer  "max_bpm"
    t.integer  "min_bpm"
    t.integer  "avg_bpm"
    t.integer  "length"
    t.boolean  "explicit"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "playlist_id"
    t.string   "refresh_token"
  end

  add_foreign_key "playlists_tracks", "playlists"
  add_foreign_key "playlists_tracks", "tracks"
end
