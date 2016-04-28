require "rails_helper"

feature "admin edits a game" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:captain) { FactoryGirl.create(:user, admin: true, team: team1) }
  let!(:game) { FactoryGirl.create(:game) }
  let!(:user1) { FactoryGirl.create(:user, team: team1) }

  before(:each) do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
  end
  scenario "authenticated admin successfully edits game" do
    click_link "Schedule"
    click_link "Edit"
    fill_in "Opponent", with: "Bearclaws"
    click_button "Save Game"

    expect(page).to have_content("Game Updated")
    expect(page).to have_content("Bearclaws")
  end

  scenario "authenticated admin does not specify required fields" do
    click_link "Schedule"
    click_link "Edit"
    fill_in "Street", with: ""
    click_button "Save Game"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Edit Game")
  end

  scenario "authenticated user visits edit game path" do
    click_link "Sign Out"
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"
    click_link "Schedule"

    expect(page).to_not have_selector(:link, "Edit")

    visit edit_game_path(game.id)

    expect(page).to have_content("Sorry, You Do Not Have Permission To Complete This Action")
  end

  scenario "unauthenticated user visits edit game path" do
    click_link "Sign Out"
    visit edit_game_path(game.id)

    expect(page).to have_content("Sorry, You Do Not Have Permission To Complete This Action")
  end
end
