require "rails_helper"

feature "authenticated user receives sms alert" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:captain) { FactoryGirl.create(:user, admin: true, team: team1) }
  let!(:player) { FactoryGirl.create(:user, team: team1) }
  let!(:game1) { FactoryGirl.create(:game, team: team1) }

  before(:each) do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: captain.email
    fill_in "Password", with: captain.password
    click_button "Sign In"
  end
  scenario "on game creation" do
    click_link "Add Game"
    fill_in "Street", with: "32 Main Street"
    fill_in "City", with: "Boston"
    select "Massachusetts", from: "State"
    fill_in "Zip Code", with: 01223
    fill_in "Date", with: "2016/05/13"
    fill_in "Time", with: "6:00 PM"
    fill_in "Opponent", with: "Wildcats"
    click_button "Save Game"

    last_message = FakeSMS.messages.last
    expect(last_message.body).to have_content(game1.game_day.strftime('%b %eth, %Y'))
    expect(last_message.body).to have_content("created")
  end

  scenario "on game edit" do
    click_link "Schedule"
    click_link "Edit"
    fill_in "Date", with: "2016/06/13"
    click_button "Save Game"

    last_message = FakeSMS.messages.last
    expect(last_message.body).to have_content("Jun 13th, 2016")
    expect(last_message.body).to have_content("edited")
  end

  scenario "on game deletion" do
    click_link "Schedule"
    click_link "Delete"

    last_message = FakeSMS.messages.last
    expect(last_message.body).to have_content(game1.game_day.strftime('%b %eth, %Y'))
    expect(last_message.body).to have_content("deleted")
  end
end
