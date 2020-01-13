class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: %i[show update destroy booking give_out return add_wish]
  before_action :load_user, only: %i[update give_out]

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

  # ---------------------

  def reserved
    table('booking')
  end

  def reading
    table('reading')
  end

  def readed
    table('readed')
  end

  def wishlist
    table('wishes')
  end

  def booking
    set_status('Зарезервирована', current_user)
  end

  def give_out
    set_status('На руках', @user)
  end

  def return
    @book.readings.create(user: @book.user)
    set_status('В наличии', nil)
  end

  def add_wish
    @book.wishes.new(user: current_user)

    if @book.save
      render json: @book, status: :created
    else
      render json: { errors: @book.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_status(status, user)
    @book.update!(status: status, user: user)
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def table(filter)
    @books = Book.all.send(filter, current_user)
    render json: @books
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
end
