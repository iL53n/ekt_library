require 'rails_helper'

feature 'Admin can edit book', %q{
  In order correct information
  As an admin
  I'd like to be able to edit books information
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:book) { create(:book) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_books'
    end

    scenario 'edit book' do
      expect(page).to have_content 'Книги(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content book.title.upcase
        expect(page).to have_content book.author

        click_on 'Редактировать'
      end

      within '.q-form' do
        fill_in 'Наименование', with: 'Test_new_title'
        fill_in 'Автор', with: 'Test_new_author'
        # select 'test-categories', :from => 'Категории'
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'Test_new_title'.upcase
        expect(page).to have_content 'Test_new_author'
        # expect(page).to have_content 'test-categories'
      end
    end
  end
end