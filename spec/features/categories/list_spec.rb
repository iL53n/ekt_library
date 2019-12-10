require 'rails_helper'

feature 'Admin can see all categories', %q{
  In order to managment categories
  As an admin
  I'd like to be able to see all categories
}, js: true do

  given(:user) { create(:user) }
  given!(:categories) { create_list(:category, 5) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(user)
      visit '/admin_categories'
    end

    scenario 'show all categories' do
      categories.each do |category|
        within '.q-table' do
          expect(page).to have_content category.title
        end
      end
    end
  end
end