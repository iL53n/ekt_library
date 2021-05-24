class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.admin?
      '/admin_books'
    else
      root_path
    end
  end
end
