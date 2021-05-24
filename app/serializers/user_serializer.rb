class UserSerializer < ActiveModel::Serializer
	attributes :id, :email, :first_name, :last_name, :admin, :created_at

  has_many :books
end