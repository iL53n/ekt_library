class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :description, :image, :status, :categories, :category_ids, :user_id, :active_user

  has_many :categories
  has_many :users
  has_many :posts
	# has_many :image, serializer: ImageSerializer
end