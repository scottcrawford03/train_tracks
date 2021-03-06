class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true
  validates :name, presence: true
  validates :token, presence: true
  has_many :playlists

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.name          = auth.info.name
    user.image_url     = auth.info.image
    user.token         = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
    user.save

    user
  end
end
