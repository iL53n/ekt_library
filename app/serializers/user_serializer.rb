class UserSerializer < ActiveModel::Serializer
	attributes :id, :email, :first_name, :last_name, :full_name_str, :admin, :created_at

  # has_many :books

  def full_name_str
    "#{object.first_name} #{object.last_name}"
  end
end
