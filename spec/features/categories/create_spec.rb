require 'rails_helper'

feature 'Admin can create new category', %q{
  In order to simplify the search books
  As an admin
  I'd like to be able to create new category
}, js: true do

  given(:user) { create(:user, admin: 'true') }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_categories'
    end

    scenario 'create new category' do
      expect(page).to have_content 'Категории(АДМИНИСТРИРОВАНИЕ)'

      click_on 'Новая категория'

      within '.q-form' do
        fill_in 'Наименование', with: 'Test_title'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'Test_title'
      end
    end
  end
end