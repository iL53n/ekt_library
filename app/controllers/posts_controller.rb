class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :create
  before_action :load_book, only: %i[create close_reading_post]

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

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def load_user
    @user = params[:user_id].nil? ? current_user : User.find(params[:user_id])
  end

  def load_book
    @book = Book.find(params[:book_id])
  end

  def post_params
    params.permit(:id, :title, :end_date, :active)
  end
end
