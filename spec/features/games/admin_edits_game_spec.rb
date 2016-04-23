require "rails_helper"

feature "admin edits a game" do
  let(:captain) { FactoryGirl.create(:user, admin: true) }
  let!(:game) { FactoryGirl.create(:game) }

  before(:each) do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
  end
  scenario "authenticated admin successfully edits game" do
    click_link "Schedule"
    click_link "Edit"
    fill_in "Street", with: "54 East Avenue"
    fill_in "Opponent", with: "Bearclaws"
    click_button "Save Game"

    expect(page).to have_content("Game Updated")
    expect(page).to have_content("54 East Avenue")
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
    click_link "Sign Up"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"
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
