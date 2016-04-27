require "rails_helper"

feature "admin deletes a game" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:captain) { FactoryGirl.create(:user, admin: true, team: team1) }
  let!(:game) { FactoryGirl.create(:game) }
  
  scenario "authenticated admin successfully deletes game" do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
    click_link "Schedule"
    click_link "Delete"

    expect(page).to have_content("Game Deleted")
    expect(page).to_not have_content(game.street)
    expect(page).to_not have_content(game.game_day)
  end
end
