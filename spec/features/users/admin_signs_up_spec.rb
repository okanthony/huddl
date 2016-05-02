require "rails_helper"

feature "admin signs up" do
  scenario "specifying valid and required information" do
    visit unauthenticated_root_path
    click_link "Sign Up"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user98@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"

    expect(page).to have_content("Account Created!")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Create Your Team")

    fill_in "Team Name", with: "Badgers"
    select "Baseball", from: "Sport"
    click_button "Create Team"

    expect(page).to have_content("Badgers Now Active!")
    expect(page).to have_content("Add Game")
  end

  scenario "required account information not specified" do
    visit unauthenticated_root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match confirmation" do
    visit unauthenticated_root_path
    click_link "Sign Up"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "wrongpassword"
    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "required team information not specified" do
    visit unauthenticated_root_path
    click_link "Sign Up"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user99@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"
    select "Baseball", from: "Sport"
    click_button "Create Team"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Create Your Team")
  end

end
