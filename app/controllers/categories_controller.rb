class CategoriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_category, only: %i[update destroy]

  def index
    @categories = Category.all
    render json: @categories
  end

  def create
    @category = Category.new(category_params)

    if @category.save!
      render json: @category, status: :created
    else
      render json: { errors: @category.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :created
    else
      render json: { errors: @category.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
  end

  private

  def load_category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.permit(:title, books: [])
  end
end