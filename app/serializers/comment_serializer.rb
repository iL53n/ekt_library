class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :body

  def author
    object.user.email
  end
end
