class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author, :body, :created

  def author
    "#{object.user.first_name} #{object.user.last_name}"
  end

  def created
    object.created_at.to_date
  end
end
