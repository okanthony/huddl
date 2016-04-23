require "rails_helper"

feature "authenticated user claims roster spot" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:game) { FactoryGirl.create(:game) }

  before(:each) do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
  scenario "successfully claims roster spot" do
    click_link "Schedule"
    click_link game.street
    click_button "Claim"

    expect(page).to have_content("#{user.first_name} #{user.last_name}")
    expect(page).to have_selector(:button, "Relinquish")
    expect(page).to_not have_selector(:button, "Claim")
  end

  scenario "successfully cancels roster spot" do
    click_link "Schedule"
    click_link game.street
    click_button "Claim"
    click_button "Relinquish"

    expect(page).to_not have_content("#{user.first_name} #{user.last_name}")
    expect(page).to have_selector(:button, "Claim")
    expect(page).to_not have_selector(:button, "Relinquish")
  end
end
