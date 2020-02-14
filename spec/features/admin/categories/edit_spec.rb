require 'rails_helper'

feature 'Admin can edit category', %q{
  In order correct information
  As an admin
  I'd like to be able to edit category's information
}, js: true do

  given(:admin) { create(:user, admin: 'true') }
  given(:user) { create(:user) }
  given!(:category) { create(:category, title: 'Old_title') }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
      visit '/admin_categories'
    end

    scenario 'can edit category with valid attr' do
      expect(page).to have_content 'Категории(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content 'Old_title'

        click_on 'Редактировать'
      end

      within '.q-form' do
        fill_in 'Наименование', with: 'New_title'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'New_title'
      end
    end

    scenario 'can not edit category with invalid attr' do
      expect(page).to have_content 'Категории(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content 'Old_title'

        click_on 'Редактировать'
      end

      within '.q-form' do
        fill_in 'Наименование', with: ' '
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'Old_title'
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_categories'
    end

    scenario 'do not see edit category button' do
      expect(page).to_not have_button 'Редактировать'
    end
  end
end