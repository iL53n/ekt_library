require 'rails_helper'

feature 'User can add the book to wishlist', %q{
  In order to create reading list
  As an user
  I'd like to be able to add the book to wishlist
}, js: true do

  given(:user) { create(:user) }
  given!(:book) { create(:book) }

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/list_books'
    end

    scenario 'booking book' do
      within '.q-table' do
        expect(page).to have_content book.title.upcase

        click_on # кнопка-сердце
        visit '/wish_list'

        expect(page).to have_content book.title.upcase
      end
    end
  end
end