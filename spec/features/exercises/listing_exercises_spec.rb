require 'rails_helper'

RSpec.feature 'listing exercises' do
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
    @e2 = @john.exercises.create(duration_in_min: 55,
                                  workout: 'Weight lifting',
                                  workout_date: 2.days.ago)

    @followings = Friendship.create(user: @john, friend: @sarah)
    # @e3 = @john.exercises.create(duration_in_min: 35,
    #                               workout: 'On treadmill',
    #                               workout_date: 8.days.ago)
  end

  scenario 'Shows user\'s exercises for the last 7 days' do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)

    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

    # expect(page).not_to have_content(@e3.duration_in_min)
    # expect(page).not_to have_content(@e3.workout)
    # expect(page).not_to have_content(@e3.workout_date)
  end

  scenario 'Shows no exercises if none created' do
    @john.exercises.destroy_all
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content('No Workout Yet.')
  end

  scenario 'shows a list of user\'s friends' do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content('My Friends')
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link("Unfollow")
  end
end
