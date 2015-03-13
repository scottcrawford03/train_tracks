class EchoNestTracks
  STATUS_RATE_LIMIT_EXCEEDED = 429
  class RateLimitExceededException < RuntimeError; end
  def self.connection
    Faraday.new url: "http://developer.echonest.com/api/v4"
  end

  def self.get_bpm_for(track)
    profile_response = profile_for(track.spotify_track_id)
    profile_response.tempo if profile_response.success?
  end

  def self.profile_for(track_id)
    response = connection.get('track/profile', authenticated_params(id: "spotify:track:#{track_id}", bucket: "audio_summary"))
    if response.status == STATUS_RATE_LIMIT_EXCEEDED
      raise RateLimitExceededException
    else
      EchoNestResponse.new(response)
    end
  rescue RateLimitExceededException
    puts "Rate limit was exceeded. Waiting..."
    sleep 40
    retry
  end

  def self.authenticated_params(options)
    options.merge(api_key: ENV.fetch('echo_nest_api_key'))
  end

  class EchoNestResponse
    def initialize(response)
      @response = response
    end

    def success?
      body['status']['message'] == 'Success'
    end

    def tempo
      body['track']['audio_summary']['tempo']
    end

    private

    def body
      JSON.parse(@response.body)['response']
    end
  end
end
