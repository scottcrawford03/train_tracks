describe "the playlist", type: :feature do
  before do
    @track = Track.create(spotify_album_url: "spotify.com",
                          spotify_album_image: "image",
                          spotify_album_name: "1989",
                          spotify_artist_url: "spotify.com",
                          spotify_artist_name: "Taylor Swift",
                          spotify_artist_id: "123ABC",
                          spotify_track_url: "spotify.com",
                          spotify_track_id: "123ABC",
                          spotify_track_name: "Shake It Off",
                          track_type: "Pop",
                          max_bpm:140,
                          min_bpm:100,
                          avg_bpm:123,
                          length: 200,
                          explicit: false)
  end

  it "has attributes" do
    expect(@track.spotify_album_url).to eq("spotify.com")
    expect(@track.spotify_album_image).to eq("image")
    expect(@track.spotify_album_name).to eq("1989")
    expect(@track.spotify_artist_url).to eq("spotify.com")
    expect(@track.spotify_artist_id).to eq("123ABC")
    expect(@track.spotify_track_id).to eq("123ABC")
    expect(@track.spotify_track_url).to eq("spotify.com")
    expect(@track.spotify_track_name).to eq("Shake It Off")
    expect(@track.track_type).to eq("Pop")
    expect(@track.max_bpm).to eq(140)
    expect(@track.min_bpm).to eq(100)
    expect(@track.avg_bpm).to eq(123)
    expect(@track.length).to eq(200)
    expect(@track.explicit).to eq(false)
  end
end
