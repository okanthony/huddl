require "rails_helper"

feature "authenticated user claims roster spot" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:user1) { FactoryGirl.create(:user, team: team1) }
  let!(:game1) { FactoryGirl.create(:game) }

  before(:each) do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"
  end
  scenario "successfully claims roster spot" do
    click_link "Schedule"
    click_link game1.game_day.strftime('%b %eth, %Y')
    click_button "Claim"

    expect(page).to have_content("#{user1.first_name} #{user1.last_name}")
    expect(page).to have_selector(:button, "Relinquish")
    expect(page).to_not have_selector(:button, "Claim")
  end

  scenario "successfully cancels roster spot" do
    click_link "Schedule"
    click_link game1.game_day.strftime('%b %eth, %Y')
    click_button "Claim"
    click_button "Relinquish"

    expect(page).to_not have_content("#{user1.first_name} #{user1.last_name}")
    expect(page).to have_selector(:button, "Claim")
    expect(page).to_not have_selector(:button, "Relinquish")
  end
end
