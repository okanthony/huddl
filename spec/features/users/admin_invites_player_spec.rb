require "rails_helper"

feature "admin invites player" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:captain) { FactoryGirl.create(:user, admin: true, team: team1) }
  let!(:user2) { FactoryGirl.create(:user, team: team1) }

  before(:each) do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
  end
  
  scenario "authenticated admin does not specify required information" do
    click_link "Invite"
    click_button "Invite"

    expect(page).to have_content("can\'t be blank")
    expect(page).to_not have_content("Player Invited")
  end
end
