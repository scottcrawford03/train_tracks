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

    it "shows error message if user doesn't fill in form" do
      visit root_path
      click_link_or_button "Generate Playlist"

      expect(page).to have_content("Length can't be blank")
      
    end

  end
end
