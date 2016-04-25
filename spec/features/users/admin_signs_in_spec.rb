require "rails_helper"

feature "admin signs in" do
  let!(:game) { FactoryGirl.create(:game) }
  scenario "existing user specifies valid email and password" do
    admin1 = FactoryGirl.create(:user, admin: true)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: admin1.email
    fill_in "Password", with: admin1.password
    click_button "Sign In"

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
    expect(admin1.admin).to eq true
  end
end
