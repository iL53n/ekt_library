class RatingsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: :create

  def create
    if current_user.voted?(@book)
      render json: { errors: @book.errors }, status: :unprocessable_entity
    else
      @rating = @book.ratings.new(rating_params)
      @rating.user = current_user

      if @rating.save
        render json: @rating, status: :created
      else
        render json: { errors: @rating.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end

  def load_book
    @book = Book.find(params[:book_id])
  end
end
