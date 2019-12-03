class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @books = Book.all
    render json: @books
  end

  def create
    @book = Book.new(book_params)

    if @book.save!
      render json: @book, status: :created
    else
      render json: { errors: @book.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private

  def book_params
    params.permit(:title, :description, :author, :image, :status)
  end
end
