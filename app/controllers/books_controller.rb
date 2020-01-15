class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: %i[show update destroy]
  before_action :load_user, only: %i[update]

  def index
    filter_books = FilterBooks.new(Book.all, current_user, params)
    @books = filter_books.call(filter_permitted_params)

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
    @book.user = @user
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

  def load_user
    @user = User.find(params[:user_id])
  end

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
                  category_ids: [])
  end

  def filter_permitted_params
    params.permit(:filter)
  end
end
