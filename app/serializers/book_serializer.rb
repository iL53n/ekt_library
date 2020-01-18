class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :description, :status, :categories, :category_ids, :user_id, :active_user, :image_url, :image

  has_many :categories
  has_many :users
  has_many :posts

  def image_url
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end