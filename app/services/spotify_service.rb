class SpotifyService
  attr_reader :connection

  def initialize(token = nil)
    header_key = "Bearer #{token}"
    @connection = Faraday.new(url: "https://api.spotify.com")
    @connection.headers = { 'Authorization' => header_key }
  end

  def top_playlists
    parse(connection.get("/v1/browse/featured-playlists"))
  end

  def playlist_tracks(tracks)
    parse(connection.get(tracks))
  end

  def create_playlist(user_id, playlist_name)
    response = connection.post("/v1/users/#{user_id}/playlists", {name: playlist_name, public: false}.to_json) do |request|
      request.headers.merge!('Content-Type' => 'application/json')
    end
    response.headers["location"]
  end

  def add_tracks_to_playlist(playlist_url, track_ids)
    connection.post("#{playlist_url}/tracks?uris=#{track_ids}")
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
