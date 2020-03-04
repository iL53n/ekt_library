class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :title,
             :author,
             :description,
             :short_description,
             :status,
             :user_id,
             :active_user,
             :image_url,
             #:image_name,
             :image,
             :current_rating,
             :image_src

  has_many :categories
  has_many :users
  has_many :posts
  has_one :image
  has_many :comments, serializer: CommentSerializer
  has_many :ratings

  def current_rating
    object.calculate_rating
  end

  def short_description
    object.description.truncate(80)
  end

  def image_url
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  # def image_name
  #   object.image.filename.to_s
  # end
end