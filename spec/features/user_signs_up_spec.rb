require "rails_helper"

feature "user signs up" do
  scenario "specifying valid and required information" do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"

    expect(page).to have_content("Account Created!")
    expect(page).to have_content("Sign Out")
  end


  scenario "required information not specified" do
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match confirmation" do
    visit root_path
    click_link "Sign Up"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "wrongpassword"
    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
