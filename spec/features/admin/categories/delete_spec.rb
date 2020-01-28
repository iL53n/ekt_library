require 'rails_helper'

feature 'Admin can delete category', %q{
  In order don't publish erroneous information
  As an admin
  I'd like to be able to delete category
}, js: true do

  given(:user) { create(:user, admin: 'true') }
  given!(:category) { create(:category) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_categories'
    end

    scenario 'delete category' do
      expect(page).to have_content 'Категории(АДМИНИСТРИРОВАНИЕ)'

      within '.q-table' do
        expect(page).to have_content category.title

        click_on 'Удалить'

        expect(page).to_not have_content category.title
      end
    end
  end
end