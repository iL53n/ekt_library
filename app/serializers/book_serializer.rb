class BookSerializer < ActiveModel::Serializer
	attributes :id, :title, :author, :description, :image, :status, :categories, :category_ids, :user_id

  has_many :categories
  belongs_to :user
	# has_many :image, serializer: ImageSerializer
end