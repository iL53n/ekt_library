class CommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :load_book, only: :create

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_book
    @book = Book.find(params[:book_id])
  end
end
