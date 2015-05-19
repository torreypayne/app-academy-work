require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

      it "shows username on the homepage after signup" do
        visit new_user_url
        fill_in 'username', with: "mark89"
        fill_in 'password', with: "password123"
        click_on "Create User"
        expect(page).to have_content "mark89"
      end
  end

end

feature "logging in and logging out" do

  before(:each) do
    visit new_user_url
    fill_in 'username', with: "mark89"
    fill_in 'password', with: "password123"
    click_on "Create User"
    expect(page).to have_content "mark89"
    click_on "Sign Out"
  end

  it "shows errors after unsuccessful login" do
    visit new_session_url
    fill_in 'username', with: "mark"
    fill_in 'password', with: "password123"
    click_on "Sign In"
    expect(page).to have_content "Invalid username or password"
  end

  it "begins with logged out state" do
    visit user_url(1)
    expect(page).to have_content "Log In"
  end

  it "doesn't show username on the homepage after logout" do

    #Sign In
    visit new_session_url
    fill_in 'Username', with: "mark89"
    fill_in 'Password', with: "password123"
    click_on "Sign In"

    expect(page).to have_content "mark89"
    click_on "Sign Out"
    expect(page).to_not have_content "mark89"
  end
end
