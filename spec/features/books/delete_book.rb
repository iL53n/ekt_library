require 'rails_helper'

feature 'Admin can delete book', %q{
  In order don't publish erroneous information
  As an admin
  I'd like to be able to delete book
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:book) { create(:book) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_books'
    end

    scenario 'delete book' do
      expect(page).to have_content 'Книги(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content book.title
        expect(page).to have_content book.author

        click_on 'УДАЛИТЬ'

        expect(page).to_not have_content book.title
        expect(page).to_not have_content book.author
      end
    end
  end
end