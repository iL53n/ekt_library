require 'rails_helper'

feature 'User can see booked book', %q{
  In order to see booked book
  As a аuthorized user
  I'd like to be able to see my booked book in the special table
}, js: true do

  given!(:user) { create(:user) }
  given!(:book) { create(:book) }
  given!(:booked_book) { create(:book) }
  given!(:booking_post) { create(:post,
                                 title: 'booking',
                                 active: true,
                                 user: user,
                                 book: booked_book) }


  describe 'Authorized user' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/reserved_books'
    end

    scenario 'show booked book(without other books)' do
      within '.q-table' do
        expect(page).to_not have_content book.title.upcase
        expect(page).to have_content booked_book.title.upcase
      end
    end
  end
end