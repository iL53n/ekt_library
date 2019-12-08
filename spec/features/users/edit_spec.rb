require 'rails_helper'

feature 'Admin can edit book', %q{
  In order correct information
  As an admin
  I'd like to be able to edit users information
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:user_2) { create(:user) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_users'
    end

    scenario 'edit user' do
      expect(page).to have_content 'Пользователи(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content user_2.first_name
        expect(page).to have_content user_2.last_name
        expect(page).to have_content user_2.email

        page.all('tr')[2].click_button 'Редактировать'
      end

      within '.q-form' do
        fill_in 'Имя', with: 'TestNewFirstName'
        fill_in 'Фамилия', with: 'TestNewLastName'
        fill_in 'Email', with: 'newemail@test.com'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'TestNewFirstName'
        expect(page).to have_content 'TestNewLastName'
        expect(page).to have_content 'newemail@test.com'
      end
    end
  end
end