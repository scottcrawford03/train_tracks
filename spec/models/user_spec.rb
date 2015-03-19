require 'rails_helper'

describe "the user", type: :feature do
  before do
    @user = User.create(name: "Scott Crawford",
                       image_url: "google.com",
                       token: "1234",
                       uid: "abc",
                       provider: "spotify" )
  end

  it "has attributes" do
    expect(@user.name).to eq("Scott Crawford")
    expect(@user.image_url).to eq("google.com")
    expect(@user.token).to eq("1234")
    expect(@user.uid).to eq("abc")
    expect(@user.provider).to eq("spotify")
  end

  it "is invalid without a provider" do
    @user.provider = nil
    expect(@user).to_not be_valid
  end

  it "has many playlists" do
    expect(@user.playlists).to eq([])
    playlist = Playlist.create(name: "Playlist",
                                intensity: "HIGH",
                                length: 1234      )
    @user.playlists << playlist

    expect(@user.playlists.first.name).to eq('Playlist')
  end

  it "saves or finds by auth" do
    auth = OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
              :provider => 'spotify',
              :uid => '123545',
              :info => {
                :name => "Scott Crawford",
                :image => "hello.com",
              },
              :credentials => {
                :token => "token",
                :refresh_token => "refresh_token"
              }
            })

    user = User.find_or_create_from_auth(auth)

    expect(user.provider).to eq ('spotify')
    expect(user.uid).to eq ('123545')
    expect(user.name).to eq ('Scott Crawford')
  end
end
