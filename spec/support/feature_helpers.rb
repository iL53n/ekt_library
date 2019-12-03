module FeatureHelpers
  def sign_in(user)
    # user_type = user.class.name.downcase.pluralize
    # visit "new_/#{user_type}/_session_path"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end