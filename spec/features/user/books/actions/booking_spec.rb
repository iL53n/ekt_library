require 'rails_helper'

feature 'User can booking book', %q{
  In order to block the book until it is received
  As an user
  I'd like to be able to booking book
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
        expect(page).to_not have_content user.first_name
        expect(page).to have_content 'Доступна'

        click_on 'Зарезервировать'

        expect(page).to have_content 'Зарезервирована'
        expect(page).to have_content user.first_name
        expect(page).to have_button 'Зарезервировать', disabled: true
      end
    end
  end
end