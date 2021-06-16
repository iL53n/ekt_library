class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :title,
             :short_title,
             :author,
             :description,
             :short_description,
             :available,
             :booking,
             :reading,
             :readed,
             :all_amount,
             :all_amount_with_booking,
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
  has_one  :image
  has_many :comments, serializer: CommentSerializer
  has_many :ratings

  def available
    object.available?
  end

  def short_title
    title = object.title.length <= 45 ? object.title : object.title.slice(0, 42).concat('...')
    "#{object.author} - #{title}"
  end

  def short_description
    descr = object.description
    descr.length <= 300 ? descr : descr.slice(0, 297).concat('...')
  end

  def current_rating
    object.calculate_rating
  end

  def image_url
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  # def image_name
  #   object.image.filename.to_s
  # end

  def string_users
    arr = []
    object.active_users.each do |user|
      string_user = "#{user.last_name} #{user.first_name}"
      arr << string_user
    end
    arr.join(', ')
  end

  def status
    object.available? ? 'available' : 'not_available'
  end
end
