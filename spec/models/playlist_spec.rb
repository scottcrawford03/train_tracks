require 'rails_helper'

describe "the playlist", type: :feature do
  before do
    puts "before do"
    @playlist = Playlist.create(name: "Playlist",
                                intensity: "HIGH",
                                length: 1234)
  end

  it "has attributes" do
    expect(@playlist.name).to eq("Playlist")
    expect(@playlist.intensity).to eq("HIGH")
    expect(@playlist.length).to eq(1234)
  end

  it "is invalid without a intensity" do
    @playlist.intensity = nil
    expect(@playlist).to_not be_valid
  end

  it "is invalid without a length" do
    @playlist.length = nil
    expect(@playlist).to_not be_valid
  end

  it "finds the length of it's playlist" do
    track1 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)
    track2 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)
    track3 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)

    @playlist.tracks << track1
    @playlist.tracks << track2
    @playlist.tracks << track3

    expect(@playlist.playlist_length).to eq(600)
  end

  it "gets the playlist track ids" do
    track1 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)
    track2 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)
    track3 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 200, explicit: false)

    @playlist.tracks << track1
    @playlist.tracks << track2
    @playlist.tracks << track3

    expect(@playlist.get_track_ids).to eq ("123ABC,123ABC,123ABC")
  end

  it "creates a mix" do
    track1 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123ABC", length: 20000, explicit: false)
    track2 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123AB3", length: 20000, explicit: false)
    track3 = Track.create(spotify_album_url: "spotify.com", spotify_track_id: "123AadC", length: 20000, explicit: false)

    sorted_tracks = [track1, track2, track3 ]
    @playlist.create_mix(sorted_tracks, '1')

    expect(@playlist.tracks.size).to eq(3)
    expect(@playlist.tracks.first.spotify_album_url).to eq('spotify.com') 
  end



end
