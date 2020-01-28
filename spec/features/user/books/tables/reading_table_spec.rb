require 'rails_helper'

feature 'User can see reading book', %q{
  In order to see reading book
  As a аuthorized user
  I'd like to be able to see my reading book in the special table
}, js: true do

  given!(:user) { create(:user) }
  given!(:book) { create(:book) }
  given!(:reading_book) { create(:book) }
  given!(:reading_post) { create(:post,
                                 title: 'reading',
                                 active: true,
                                 user: user,
                                 book: reading_book) }


  describe 'Authorized user' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/reading_books'
    end

    scenario 'show reading book(without other books)' do
      within '.q-table' do
        expect(page).to_not have_content book.title.upcase
        expect(page).to have_content reading_book.title.upcase
      end
    end
  end
end