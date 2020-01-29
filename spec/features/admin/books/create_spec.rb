require 'rails_helper'

feature 'Admin can create new book', %q{
  In order add new book to libraries
  As an admin
  I'd like to be able to create new book
}, js: true do

  given(:admin) { create(:user, admin: 'true') }
  given(:user) { create(:user) }
  given!(:category) { create(:category, title: 'books_category') }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
      visit '/admin_books'
    end

    scenario 'can create new book with valid attr' do
      expect(page).to have_content 'Книги(АДМИНИСТРИРОВАНИЕ)'

      click_on 'Новая книга'
      within '.q-form' do
        fill_in 'Наименование *', with: 'Test_title'
        fill_in 'Автор *', with: 'Test_author'
        attach_file 'Обложка книги *', ["#{Rails.root}/app/javascript/images/Logo.png"]
        fill_in 'Описание', with: 'Test_description'
        select('books_category', from: find('#Категории'))
        select 'available', from: find('#Статус')
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to have_content 'Test_title'.upcase
        expect(page).to have_content 'Test_author'
        expect(page).to have_content 'test-categories'
      end
    end

    scenario 'can not create new book with invalid attr' do
      expect(page).to have_content 'Книги(АДМИНИСТРИРОВАНИЕ)'

      click_on 'Новая книга'
      within '.q-form' do
        fill_in 'Наименование *', with: ''
        fill_in 'Автор *', with: ''
        fill_in 'Описание', with: ''
        click_on 'СОХРАНИТЬ'
      end

      within '.q-table' do
        expect(page).to_not have_content 'Test_title'.upcase
        expect(page).to_not have_content 'Test_author'
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_books'
    end

    scenario 'do not see new book button' do
      expect(page).to_not have_button 'Новая книга'
    end
  end
end