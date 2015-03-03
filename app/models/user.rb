class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.name      = auth.info.name
    user.image_url  = auth.info.image
    user.token      = auth.credentials.token

    user.save

    user
  end
end
