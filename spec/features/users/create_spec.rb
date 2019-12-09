require 'rails_helper'

feature 'Admin can create new user', %q{
  In order add new user to libraries
  As an admin
  I'd like to be able to create new user
}, js: true do

  given(:user) { create(:user, admin: 'true') }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_users'
    end

    scenario 'create new user' do
      expect(page).to have_content 'Пользователи(АДМИНИСТРИРОВАНИЕ)'

      click_on 'Новый пользователь'
      within '.q-form' do
        fill_in 'Имя', with: 'FirstNameNEW'
        fill_in 'Фамилия', with: 'LastNameNEW'
        fill_in 'Email', with: 'usernew@test.com'
        fill_in 'Пароль', with: 'password'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'FirstNameNEW'
        expect(page).to have_content 'LastNameNEW'
        expect(page).to have_content 'usernew@test.com'
      end
    end
  end
end