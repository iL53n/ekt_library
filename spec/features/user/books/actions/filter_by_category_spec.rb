require 'rails_helper'

feature 'User can filter book by category', %q{
  In order to find the book I need
  As an user
  I'd like to be able to filter book by category
}, js: true do

  given(:user) { create(:user) }
  given!(:first_category) { create(:category, title: 'first_category') }
  given!(:second_category) { create(:category, title: 'second_category') }
  given!(:first_book) { create(:book, categories: [first_category]) }
  given!(:second_book) { create(:book, categories: [second_category]) }
  given!(:third_book) { create(:book) }

  describe 'User filter the book' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/list_books'
    end

    scenario 'by category' do
      expect(page).to have_content 'Отбор по категории'
      select 'first_category', from: 'Отбор по категории' # ToDo: don't work... why?

      within '.q-table' do
        expect(page).to have_content first_book.title.upcase
        expect(page).to_not have_content second_book.title.upcase
        expect(page).to_not have_content third_book.title.upcase
      end
    end
  end
end