class BookSerializer < ActiveModel::Serializer
	attributes :id, :title, :author, :description, :image, :status, :categories, :category_ids

  has_many :categories
	# has_many :image, serializer: ImageSerializer
end