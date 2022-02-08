require 'rails_helper'

RSpec.feature 'Unfollowing friends' do
  before do
    @john = User.create!(email: 'john@example.com',
                          password: 'password',
                          first_name: "John",
                          last_name: 'Doe')
    @sarah = User.create!(email: 'sarah@example.com',
                          password: 'password',
                          first_name: "Sarah",
                          last_name: 'Anderson')
    login_as(@john)

    @followings = Friendship.create(user: @john, friend: @sarah)
  end

  scenario 'Show friend\'s workout for the last 7 days' do

    visit '/'
    click_link "My Lounge"

    link = "a[href='/friendships/#{@followings.id}'][data-method='delete']"
    find(link).click
    expect(page).to have_content(@sarah.full_name + ' unfollowed.')
  end
end
