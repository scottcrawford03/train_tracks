require "spec_helper"

describe "the guest view", type: :feature do
  describe "the home page" do

    before do
      visit root_path
    end

    it "loads the homepage" do
      expect(page.status_code).to eq(200)
    end

    it "has the site title" do
      expect(page).to have_content('TrainTracks')
    end
  end
end
