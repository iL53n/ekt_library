class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :title,
             :author,
             :description, :short_description,
             :status,
             :user_id,
             :active_user,
             :image_url,
             :image

  has_many :categories
  has_many :users
  has_many :posts
  has_one :image
  has_many :comments, serializer: CommentSerializer
  has_many :ratings

  def short_description
    object.description.truncate(80)
  end

  def image_url
    # rails_blob_path(object.image, only_path: true) if object.image.attached?
    rails_blob_url(object.image, only_path: true) if object.image.attached?
    # rails_representation_url(object.image.variant(resize: "300x300").processed, only_path: true)
    # object.image.variant(resize: "100x100>").processed.service_url
  end
end