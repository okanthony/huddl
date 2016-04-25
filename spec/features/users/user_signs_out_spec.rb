require "rails_helper"

feature "user signs out" do
  let!(:game) { FactoryGirl.create(:game) }
  scenario "logged in user successfully signs out" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Sign Out"

    expect(page).to have_content("See Ya!")
    expect(page).to_not have_content("Sign Out")
  end
end
