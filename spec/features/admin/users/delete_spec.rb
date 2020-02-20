require 'rails_helper'

feature 'Admin can delete user', %q{
  In order don't give access
  As an admin
  I'd like to be able to delete user
}, js: true do

  given!(:admin) { create(:user, admin: 'true') }
  given!(:user) { create(:user) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
      visit '/admin_users'
    end

    scenario 'can delete user' do
      expect(page).to have_content 'Пользователи(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content user.email
        page.all('tr')[2].click_button 'Удалить'
      end

      within '.q-dialog-plugin' do
        click_on 'Да'
      end

      within '.q-table' do
        expect(page).to_not have_content user.email
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_users'
    end

    scenario 'can not see delete user button' do
      expect(page).to_not have_button 'Удалить'
    end
  end
end