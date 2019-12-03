require 'rails_helper'

feature 'Admin can create new book', %q{
  In order add new book to libraries
  As an admin
  I'd like to be able to create new book
}, js: true do

  given(:user) { create(:user, admin: 'true') }

  describe 'Admin' do
		background do
			visit new_user_session_path
			sign_in(user)
			visit '/admin_books'
		end

		scenario 'create new book' do
			expect(page).to have_content 'Книги(АДМИНИСТРИРОВАНИЕ)'

			click_on 'Новая книга'
			fill_in 'Наименование', with: 'Test_title'
			fill_in 'Автор', with: 'Test_author'
			fill_in 'Изображение', with: 'Test_image'
			fill_in 'Описание', with: 'Test_description'
			fill_in 'Статус', with: 'OK'
			click_on 'СОХРАНИТЬ'

			within '.q-table' do
				expect(page).to have_content 'Test_title'
				expect(page).to have_content 'Test_author'
			end
		end
	end
end