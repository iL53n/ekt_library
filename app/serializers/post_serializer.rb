class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :end_date

  belongs_to :book
  belongs_to :user
end