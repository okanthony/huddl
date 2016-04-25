require "rails_helper"

feature "user signs in" do
  let!(:game) { FactoryGirl.create(:game) }
  scenario "existing user specifies valid email and password" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
  end

  scenario "nonexistent email and password supplied" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: "some_email@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an existing email with wrong password is denied access" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "authenticated user cannot re-sign in" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")

    visit new_user_session_path

    expect(page).to have_content("You are already signed in")
  end
end
