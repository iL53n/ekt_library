class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date

  belongs_to :book
  belongs_to :user

  def start_date
    object.created_at.to_date
  end
end
