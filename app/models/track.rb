class Track < ActiveRecord::Base
  has_and_belongs_to_many :playlists

  validates :spotify_track_id, uniqueness: true

  INTENSITY_RANGES = {"LOW" => (1..100),
                      "MEDIUM" => (101..130),
                      "HIGH" => (131..200) }

  def self.track_intensity(intensity)
    where(avg_bpm: (INTENSITY_RANGES[intensity]))
  end

  def self.save_tracks_from_spotify(tracks)
     tracks.each do |track|
       track['items'].each do |item|
         unless item['track']['album']['images'].empty?
           Track.create(
            spotify_album_image: item['track']['album']['images'].first['url'],
            spotify_album_name:  item['track']['album']['name'],
            spotify_album_url:   item['track']['album']['external_urls']['spotify'],
            spotify_artist_name: item['track']['artists'].first['name'],
            spotify_artist_url:  item['track']['artists'].first['external_urls']['spotify'],
            spotify_track_name:  item['track']['name'],
            spotify_track_id:    item['track']['id'],
            spotify_track_url:   item['track']['external_urls']['spotify'] ,
            length:              item['track']['duration_ms'],
            explicit:            item['track']['explicit']
            )
          end
       end
     end
  end

  def album_display_image
    if spotify_album_image
      return spotify_album_image
    else
      return "TTlogo.png"
    end
  end

end
