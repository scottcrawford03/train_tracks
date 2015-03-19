describe "the track", type: :feature do
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

  it "Grabs High Intensity Songs" do
    track1 = Track.create(spotify_track_name: "Shake It Off", avg_bpm:180)
    track3 = Track.create(spotify_track_name: "YOLO", avg_bpm:1)

    sorted_tracks = Track.track_intensity('HIGH')
    expect(sorted_tracks.first.avg_bpm).to eq(track1.avg_bpm)
  end

  it "only grabs songs in Medium" do
    sorted_tracks = Track.track_intensity('MEDIUM')
    expect(sorted_tracks.first.avg_bpm).to eq(@track.avg_bpm)
  end

  it "only grabs songs in LOW" do
    track3 = Track.create(spotify_track_name: "YOLO", avg_bpm:1)
    track1 = Track.create(spotify_track_name: "Shake It Off", avg_bpm:180)

    sorted_tracks = Track.track_intensity('LOW')
    expect(sorted_tracks.first.avg_bpm).to eq(track3.avg_bpm)
  end

  it "has a default album image" do
    @track.spotify_album_image = nil

    expect(@track.album_display_image).to eq("TTlogo.png")
  end

  it "returns spotify album image if present" do
    expect(@track.album_display_image).to eq("image")
  end

  it "finds ranges based on intensity" do
    expect(Track::INTENSITY_RANGES['LOW']).to eq(1..100)
    expect(Track::INTENSITY_RANGES['MEDIUM']).to eq(101..130)
    expect(Track::INTENSITY_RANGES['HIGH']).to eq(131..200)
  end

  it "saves the tracks to a track item" do
   tracks = [{'items' =>
            [{ 'track' => {
                'album' => {
                  'images' => [
                    {'url' => 'hello.com'} ],
                  'name' => 'Seven Nation Army',
                  'external_urls' => { 'spotify' => 'hello.com'} },
                'artists' => [{
                  'name' => 'Zella Day',
                  'external_urls' => {
                    'spotify' => 'hello.com' } }],
                'name' => 'Shake it Off',
                'id' => 1,
                'duration_ms' => 400,
                'explicit' => false,
                'external_urls' => { 'spotify' => 'hello.io'}
              }  } ]}]

    Track.save_tracks_from_spotify(tracks)
    track = Track.find_by(spotify_artist_name: 'Zella Day')

    expect(track.length).to eq(400)
    expect(track.explicit).to eq(false)
    expect(track.spotify_track_url).to eq('hello.io') 
  end

end
