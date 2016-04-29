require "rails_helper"

feature "admin adds a game" do
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
  scenario "authenticated admin specifies valid game attributes" do
    expect(page).to have_content("Welcome, #{captain.first_name}")

    click_link "Add Game"
    fill_in "Street", with: "32 Main Street"
    fill_in "City", with: "Boston"
    select "Massachusetts", from: "State"
    fill_in "Zip Code", with: 01223
    fill_in "Date", with: "2016/05/13"
    fill_in "Time", with: "6:00 PM"
    fill_in "Opponent", with: "Wildcats"
    click_button "Save Game"

    expect(page).to have_content(game.game_day.strftime('%b %eth, %Y'))
    expect(page).to have_content(game.game_time.strftime('%l:%M %p'))
    expect(page).to have_content("vs. #{game.opponent}")
  end

  scenario "authenticated admin does not specify opponent" do
    click_link "Add Game"
    fill_in "Street", with: "32 Main Street"
    fill_in "City", with: "Boston"
    select "Massachusetts", from: "State"
    fill_in "Zip Code", with: 01223
    fill_in "Date", with: "2016/04/29"
    fill_in "Time", with: "6:00 PM"
    click_button "Save Game"

    expect(page).to_not have_content("can't be blank")
  end

  scenario "authenticated admin does not specify required fields" do
    click_link "Add Game"
    click_button "Save Game"

    expect(page).to have_content("can't be blank")
  end

  scenario "authenticated user visits new game path" do
    click_link "Sign Out"
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.email
    click_button "Sign In"
    visit new_game_path

    expect(page).to have_content("Sorry, You Do Not Have Permission To Complete This Action")
  end

  scenario "unauthenticated user visits new game path" do
    click_link "Sign Out"
    visit new_game_path

    expect(page).to have_content("Sorry, You Do Not Have Permission To Complete This Action")
  end
end
