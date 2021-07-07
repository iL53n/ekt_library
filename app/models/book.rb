class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :number_of, presence: true

  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  # scopes_by_posts_status
  def booking
    scope_by_status('booking', true)
  end

  def reading
    scope_by_status('reading', true)
  end

  def readed
    scope_by_status('reading', false)
  end

  def wish
    scope_by_status('wish', false)
  end

  def scope_by_status(title, active)
    posts.where(title: title, active: active)
  end

  # calculating
  def all_amount
    number_of - reading.count
  end

  def all_amount_with_booking
    number_of - not_available
  end

  def not_available
    booking.count + reading.count
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

  ###
  def close_booking_post(user_id)
    active_booking_posts = active_posts&.where(title: 'booking', user_id: user_id)
    active_booking_posts&.each { |p| p.update!(active: false, end_date: Time.now) }
  end

  def reading_users
    reading&.map { |post| post.user }
  end

  # def booking_users_str
  #   booking.map { |post| "#{post.user.last_name} #{post.user.first_name} \" #{post.created_at.to_date} \"" }
  # end

  def available?
    self.all_amount_with_booking > 0
  end

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
end
