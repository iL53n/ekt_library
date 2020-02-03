require 'rails_helper'

feature 'User can see show books form', %q{
  In order to see all information about the book
  As an user
  I'd like to be able to see show books form
}, js: true do

  given(:user) { create(:user) }
  given!(:book) { create(:book_with_categories, count: 3) }

  describe 'User can see content' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/list_books'
    end

    def book_status
      statuses = { 'booking': 'Зарезервирована', 'reading': 'На руках', 'available': 'Доступна' }
      statuses[book.status]
    end

    scenario 'show form if click title in the books table' do
      within '.q-table' do
        expect(page).to have_content book.title.upcase
        find('.q-btn__content', text: "#{book.title.upcase}").click
      end

      within '.q-card' do
        expect(page).to have_content book.title
        expect(page).to have_content book.author
        expect(page).to have_content book_status
        expect(page).to have_content book.description
        book.categories { |category| expect(page).to have_content category }
      end
    end
  end
end