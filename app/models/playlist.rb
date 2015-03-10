class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :tracks, uniq: true
  belongs_to :user

  validates :length, presence: true, :numericality => {:greater_than => 0, :less_than => 61, :only_integer => true}
  validates :intensity, presence: true

  def playlist_length
    tracks.inject(0) { |sum, track| sum + (track.length)}
  end

  def create_mix(sorted_tracks, time)
    while playlist_length < (time.to_i * 60) do
      track = sorted_tracks.to_a.shuffle.pop
      tracks << track unless tracks.exists?(track)
    end
  end
end
