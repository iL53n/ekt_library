class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :body, :created

  def author
    object.user.email
  end

  def created
    object.created_at.to_date
  end
end
