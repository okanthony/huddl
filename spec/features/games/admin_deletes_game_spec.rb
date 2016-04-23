require "rails_helper"

feature "admin deletes a game" do
  let(:captain) { FactoryGirl.create(:user, admin: true) }
  let!(:game) { FactoryGirl.create(:game) }

  before(:each) do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
  end
  scenario "authenticated admin successfully deletes game" do
    click_link "Schedule"
    click_link "Delete"

    expect(page).to have_content("Game Deleted")
    expect(page).to_not have_content(game.street)
    expect(page).to_not have_content(game.game_day)
  end
end
