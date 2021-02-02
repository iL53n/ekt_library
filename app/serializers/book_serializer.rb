class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :title,
             :author,
             :description,
             :short_description,
             :status,
             :booking,
             :reading,
             :readed,
             :all_amount,
             :user_id,
             :active_users,
             :string_users,
             :image_url,
             #:image_name,
             :image,
             :current_rating,
             :image_src,
             :number_of

  has_many :categories
  has_many :users
  has_many :posts
  has_one :image
  has_many :comments, serializer: CommentSerializer
  has_many :ratings

  def current_rating
    object.calculate_rating
  end

  def short_description
    descr = object.description
    descr.length <= 300 ? descr : descr.slice(0, 297).concat('...')
  end

  def image_url
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  # def image_name
  #   object.image.filename.to_s
  # end

  # ToDo: where we use it?
  # def start_date_post
  #   object.active_post&.created_at&.to_date
  # end

  def string_users
    arr = []

    object.active_users.each do |user|
      string_user = "#{user.last_name} #{user.first_name}"
      arr << string_user
    end

    arr

    arr.join(', ')
  end
end
