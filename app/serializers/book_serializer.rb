class BookSerializer < ActiveModel::Serializer
	attributes :id, :title, :author, :description, :image, :status

	#has_many :image, serializer: ImageSerializer
end