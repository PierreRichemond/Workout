require 'rails_helper'

RSpec.feature 'Signing out' do
  before do
    @john = User.create!(email: 'john@example.com',
                          password: "password",
                          first_name: "John",
                          last_name: 'Doe'
    )
    login_as(@john)
  end

  scenario 'a logged in user can sign out' do
    visit '/'
    click_link 'Sign out'

    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end
end
