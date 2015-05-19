require 'spec_helper'
require 'rails_helper'


feature "Create a New goal" do

  before(:each) do
    visit new_user_url
    fill_in 'username', with: "mark89"
    fill_in 'password', with: "password123"
    click_on "Create User"
  end

  it "Has a create new goal link" do
    visit goals_url
    expect(page).to have_link('Create New Goal')
  end

  it "Has a Create new goal form" do
    visit new_goal_url
    fill_in 'Title', with: "Go Running"
    fill_in 'Body', with: "Go Running 4 times a week"
    click_on "Create New Goal"
    expect(page).to have_content('Go Running')
  end

end

feature "Public and Private Goals" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  before(:each) do
    FactoryGirl.create(:goal, user_id: user1.id)
    FactoryGirl.create(:goal, user_id: user1.id, visibility: "Private")
  end

  it "Shows public goals" do

    visit new_session_url

    fill_in 'username', with: user2.username
    fill_in 'password', with: user2.password
    click_on 'Sign In'
    visit goals_url
    byebug
    save_and_open_page

    expect(page).to have_content(user1.goals.first.title)
  end
end
