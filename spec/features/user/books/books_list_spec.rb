require 'rails_helper'

feature 'User can see all books', %q{
  In order to find the right book
  As a аuthorized user
  I'd like to be able to see all books
} do

  given(:user) { create(:user) }
  given!(:books) { create_list(:book, 5) }

  describe 'Authorized user', js: true do
    background do
      visit new_user_session_path
      sign_in(user)
      visit books_index_path
    end

    scenario 'show all books' do
      books.each do |book|
        within 'table' do
          expect(page).to have_content book.title
        end
      end
    end
  end
end