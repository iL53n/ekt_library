class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :create
  before_action :load_book, only: %i[create close_reading_post]
  # after_action :update_book, only: :create

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new(post_params)
    @post.user = @user
    @post.book = @book

    if @post.save
      @book.close_booking_post(@user.id) if params[:title] == 'reading'
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  # def close_reading_post
  #   @book.update(status: 'available', user_id: nil)
  #   @book.close_active_post
  # end

  private

  def load_user
    @user = params[:user_id].nil? ? current_user : User.find(params[:user_id])
  end

  def load_book
    @book = Book.find(params[:book_id])
  end

  # def update_book
  #   unless wish?
  #     status = @book.available? ? 'available' : params[:title]
  #     @book.update(status: status, user_id: @user.id)
  #   end
  # end

  def booking?
    params[:title] == 'booking'
  end

  # def wish?
  #   params[:title] == 'wish'
  # end

  def post_params
    params.permit(:title, :end_date, :active)
  end
end
