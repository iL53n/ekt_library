require 'rails_helper'

feature 'Admin can see all books', %q{
  In order to admin books
  As an admin
  I'd like to be able to see all books
}, js: true do

  given(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }
  given!(:books) { create_list(:book, 5) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
    end

    scenario 'can see redirect to books admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to have_content 'Книги'
      end
    end

    scenario 'can see all books' do
      visit '/admin_books'

      books.each do |book|
        within '.q-table' do
          expect(page).to have_content book.title.upcase
          expect(page).to have_content book.author
        end
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
    end

    scenario 'can not see redirect to books admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to_not have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to_not have_content 'Книги'
      end
    end

    scenario 'can not see all books in admin table' do
      visit '/admin_books'

      expect(page).to_not have_content book.title.upcase
      expect(page).to_not have_content book.author
    end
  end
end