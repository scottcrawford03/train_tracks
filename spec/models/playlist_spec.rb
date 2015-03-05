require 'rails_helper'

describe "the playlist", type: :feature do
  before do
    @playlist = Playlist.create(name: "Playlist",
                                intensity: "HIGH",
                                length: 1234)
  end

  it "has attributes" do
    expect(@playlist.name).to eq("Playlist")
    expect(@playlist.intensity).to eq("HIGH")
    expect(@playlist.length).to eq(1234)
  end

  it "is invalid without a intensity" do
    @playlist.intensity = nil
    expect(@playlist).to_not be_valid
  end

  it "is invalid without a length" do
    @playlist.length = nil
    expect(@playlist).to_not be_valid
  end
end
