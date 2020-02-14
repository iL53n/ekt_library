class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :create
  before_action :load_book, only: %i[create close_reading_post]
  after_action :update_book, only: :create

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new(post_params)

    @post.user = @user
    # закрываем старую активную запись(post) к книге, чтобы создать новую(одновременно не может быть более одной активной)
    @book.close_active_post unless wish?
    # создаем новую запись к книге
    @post.book = @book

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def close_reading_post
    @book.update(status: 'available', user_id: nil)
    @book.close_active_post
  end

  private

  def load_user
    @user = params[:user_id].nil? ? current_user : User.find(params[:user_id])
  end

  def load_book
    @book = Book.find(params[:book_id])
  end

  def update_book
    @book.update(status: params[:title], user_id: @user.id) unless wish?
  end

  def wish?
    params[:title] == 'wish'
  end

  def post_params
    params.permit(:title, :end_date, :active)
  end
end
