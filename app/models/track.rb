class Track < ActiveRecord::Base
  has_and_belongs_to_many :playlists

  INTENSITY_RANGES = {"LOW" => (1..60),
                      "MEDIUM" => (61..120),
                      "HIGH" => (121..200) }

  def self.track_intensity(intensity)
    where(avg_bpm: (INTENSITY_RANGES[intensity]))
  end
end
