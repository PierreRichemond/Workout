require 'rails_helper'

RSpec.feature 'Following friends' do
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

    @e1 = @john.exercises.create(duration_in_min: 20,
                                  workout: 'My body building activity',
                                  workout_date: Date.today)
    @e2 = @sarah.exercises.create(duration_in_min: 55,
                                  workout: 'Weight lifting',
                                  workout_date: 2.days.ago)

    @followings = Friendship.create(user: @john, friend: @sarah)

  end

  scenario 'Show friend\'s workout for the last 7 days' do
    visit '/'

    click_link "My Lounge"
    click_link @sarah.full_name
    expect(page).to have_content("#{@sarah.full_name}'s exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end
end
