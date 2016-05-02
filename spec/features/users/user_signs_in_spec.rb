require "rails_helper"

feature "user signs in" do
  let!(:team1) { FactoryGirl.create(:team) }
  let!(:user1) { FactoryGirl.create(:user, team: team1) }
  scenario "existing user specifies valid email and password" do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("#{team1.name}")
    expect(page).to_not have_content("Add Game")
  end

  scenario "existing admin specifies valid email and password" do
    admin1 = FactoryGirl.create(:user, admin: true, team: team1)
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: admin1.email
    fill_in "Password", with: admin1.password
    click_button "Sign In"

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("#{team1.name}")
    expect(page).to have_content("Add Game")
  end

  scenario "nonexistent email and password supplied" do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: "some_email@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an existing email with wrong password is denied access" do
    visit unauthenticated_root_path
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: "wrongpassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "authenticated user cannot re-sign in" do
    visit new_user_session_path
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")

    visit new_user_session_path

    expect(page).to have_content("You are already signed in")
  end
end
