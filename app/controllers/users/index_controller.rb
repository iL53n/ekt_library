class Users::IndexController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :destroy

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      render json: @user, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def me
    @user = current_user
    render json: @user
  end

  def show; end

  def destroy
    @user.destroy
  end

  private

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.permit(:id, :first_name, :last_name, :email, :admin, :password)
  end
end
