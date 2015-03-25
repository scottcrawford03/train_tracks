class AlbumsController < ApplicationController
  def index
    @images_and_urls = Track.where.not(spotify_album_image: nil).pluck(:spotify_album_image, :spotify_album_url).uniq.sample(300)
  end
end
