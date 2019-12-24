class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :end_date)
  end
end
