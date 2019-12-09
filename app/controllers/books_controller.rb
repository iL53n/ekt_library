class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: %i[show update destroy]

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

  def show
    render json: @book, status: :ok
  end

  def update
    if @book.update!(book_params)
      render json: @book, status: :created
    else
      render json: { errors: @book.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  private

  def load_book
    @book ||= Book.find(params[:id])
  end

  def book_params
    params.permit(:id,
                  :title,
                  :description,
                  :author,
                  :image,
                  :status,
                  category_ids: [],
                  categories: []
    )
  end
end
