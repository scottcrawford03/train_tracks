class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :tracks, uniq: true
  belongs_to :user

  validates :length, presence: true, :numericality => {:greater_than => 0, :less_than => 120, :only_integer => true}
  validates :intensity, presence: true

  def playlist_length
    tracks.inject(0) { |sum, track| sum + (track.length) }
  end

  def create_mix(sorted_tracks, time)
    while playlist_length < (to_milliseconds(time)) do
      track = sorted_tracks.to_a.shuffle.pop
      tracks << track unless tracks.exists?(track.id)
    end
  end

  def get_track_ids
    tracks.inject([]) {|arr, track| arr << track.spotify_track_id}.join(',')
  end

  private

  def to_milliseconds(time)
    time.to_i * 60 * 1000
  end
end
