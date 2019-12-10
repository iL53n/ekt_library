require 'rails_helper'

feature 'Admin can see all users', %q{
  In order to find the user
  As an admin
  I'd like to be able to see all users
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:users) { create_list(:user, 5) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_users'
    end

    scenario 'show all users' do
      users.each do |user|
        within '.q-table' do
          expect(page).to have_content user.email
        end
      end
    end
  end
end