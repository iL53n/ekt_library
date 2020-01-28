require 'rails_helper'

feature 'User can see wish book', %q{
  In order to see wish book
  As a аuthorized user
  I'd like to be able to see my wish book in the wishlist
}, js: true do

  given!(:user) { create(:user) }
  given!(:book) { create(:book) }
  given!(:wish_book) { create(:book) }
  given!(:wish_post) { create(:post,
                                 title: 'wish',
                                 active: false,
                                 user: user,
                                 book: wish_book) }


  describe 'Authorized user' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/wish_list'
    end

    scenario 'show wish book(without other books)' do
      within '.q-table' do
        expect(page).to_not have_content book.title.upcase
        expect(page).to have_content wish_book.title.upcase
      end
    end
  end
end