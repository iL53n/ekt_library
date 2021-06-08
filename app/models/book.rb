class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            # :status,
            :number_of, presence: true

  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  # scopes_by_status
  def booking
    scope_by_status('booking', true)
  end

  def reading
    scope_by_status('reading', true)
  end

  def readed
    scope_by_status('reading', false)
  end

  def scope_by_status(title, active)
    posts.where(title: title, active: active)
  end

  # calculating
  def all_amount
    number_of - (booking.count + reading.count)
  end

  def calculate_rating
    ratings.sum(&:value) / ratings.count if ratings.any?
  end

  def calculate_readed
    readed.count if posts.any?
  end

  def calculate_commented
    comments.count if comments.any?
  end

  #

  def available?
    self.all_amount > 0
  end

  def include_booking?(user_id) # if we want blocker any booking post
    posts.where(user_id: user_id)
  end

  def close_booking_post(user_id)
    post = active_posts&.where(title: 'booking', active: true, user_id: user_id)
    post.update(active: false, end_date: Time.now)
  end

  ###

  def include_reading?(user_id)
    self.posts.where(user_id: user_id)
  end

  def close_reading(user_id)
    post = active_posts&.where(title: 'reading', active: true, user_id: user_id)
    post.update(active: false, end_date: Time.now)
  end

  def active_users
    active_posts&.map { |post| post.user }
  end

  def active_posts
    posts.where(active: true)
  end

  # def close_active_post
  #   active_post&.update!(active: false, end_date: Time.now)
  # end

  def close_active_post(user_id)
    post = active_posts&.where(user_id: user_id)
    post.update(active: false, end_date: Time.now)
  end
end
