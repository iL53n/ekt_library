require 'rails_helper'

feature 'Admin can see all users', %q{
  In order to managment users
  As an admin
  I'd like to be able to see all users
}, js: true do

  given(:admin) { create(:user, admin: 'true') }
  given(:user) { create(:user) }
  given!(:posts) { create_list(:post, 5) }

  describe 'Admin' do
    background do
      visit new_user_session_path
      sign_in(admin)
    end

    scenario 'can see redirect to posts admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to have_content 'Записи'
      end
    end

    scenario 'show all posts' do
      visit '/index_posts'

      posts.each do |post|
        within '.q-table' do
          expect(page).to have_content post.title
          expect(page).to have_content post.end_date
        end
      end
    end
  end

  describe 'User' do
    background do
      visit new_user_session_path
      sign_in(user)
    end

    scenario 'can not see redirect to posts admin button' do
      visit root_path

      click_on 'profile'
      within '.q-menu' do
        expect(page).to_not have_content 'АДМИНИСТРИРОВАНИЕ'
        expect(page).to_not have_content 'Записи'
      end
    end

    scenario 'can not see all posts in admin table' do
      visit '/index_posts'

      expect(page).to_not have_css '.q-table'

      posts.each do |post|
        expect(page).to_not have_content post.title
        expect(page).to_not have_content post.end_date
      end
    end
  end
end