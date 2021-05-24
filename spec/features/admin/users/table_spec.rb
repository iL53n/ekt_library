require 'rails_helper'

feature 'Admin can see all users', %q{
  In order to managment users
  As an admin
  I'd like to be able to see all users
}, js: true do

  given(:admin) { create(:user, admin: 'true') }
  given(:user) { create(:user) }
  given!(:users) { create_list(:user, 5) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
    end

    scenario 'can see redirect to users admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to have_content 'Пользователи'
      end
    end

    scenario 'show all users' do
      visit '/admin_users'

      users.each do |user|
        within '.q-table' do
          expect(page).to have_content user.email
        end
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
    end

    scenario 'can not see redirect to users admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to_not have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to_not have_content 'Пользователи'
      end
    end

    scenario 'can not see all users in admin table' do
      visit '/admin_users'

      expect(page).to_not have_css '.q-table'

      users.each do |user|
        expect(page).to_not have_content user.email
      end
    end
  end
end