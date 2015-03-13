class SpotifyService
  attr_reader :connection

  def initialize(token = nil)
    header_key = "Bearer #{token}"
    @connection = Faraday.new(url: "https://api.spotify.com")
    @connection.headers = { 'Authorization' => header_key }
  end

  def tracks(ids)
    parse(connection.get("/v1/tracks?ids=#{ids}"))
  end

  def top_playlists
    parse(connection.get("/v1/browse/featured-playlists"))
  end

  def playlist_tracks(tracks)
    parse(connection.get(tracks))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
