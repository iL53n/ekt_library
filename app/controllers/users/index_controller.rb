class Users::IndexController < ApplicationController
  before_action :authenticate_user!

  def users
    @users = User.all
    render json: @users
  end

  def user
    @user = current_user
    render json: @user
  end
end
