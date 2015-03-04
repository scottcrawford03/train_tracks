class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :tracks

  validates :length, presence: true, :numericality => {:greater_than => 0, :only_integer => true}
  validates :intensity, presence: true

  def playlist_length
    tracks.inject(0) { |sum, track| sum + (track.length)}
  end

  def create_mix(sorted_tracks, time)
    while playlist_length < (time.to_i * 60) do
    tracks << sorted_tracks.shuffle.pop
    end
  end
end
