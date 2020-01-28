require 'rails_helper'

feature 'Admin can delete user', %q{
  In order don't give access
  As an admin
  I'd like to be able to delete user
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:user_2) { create(:user) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_users'
    end

    scenario 'delete user' do
      expect(page).to have_content 'Пользователи(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content user_2.first_name
        expect(page).to have_content user_2.last_name
        expect(page).to have_content user_2.email

        page.all('tr')[2].click_button 'Удалить'

        expect(page).to_not have_content user_2.first_name
        expect(page).to_not have_content user_2.last_name
        expect(page).to_not have_content user_2.email
      end
    end
  end
end