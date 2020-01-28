require 'rails_helper'

feature 'Admin can edit category', %q{
  In order correct information
  As an admin
  I'd like to be able to edit category's information
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:category) { create(:category) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_categories'
    end

    scenario 'edit category' do
      expect(page).to have_content 'Категории(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content category.title

        click_on 'Редактировать'
      end

      within '.q-form' do
        fill_in 'Наименование', with: 'Category_new_title'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'Category_new_title'
      end
    end
  end
end