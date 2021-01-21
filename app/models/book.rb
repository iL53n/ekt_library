class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :status,
            :number_of, presence: true

  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def calculate_rating
    ratings.sum(&:value) / ratings.count if ratings.any?
  end

  def calculate_readed
    posts.where(title: 'reading', active: false).count if posts.any?
  end

  def calculate_commented
    comments.count if comments.any?
  end

  def available?
    # !posts.where(active: true).exists?
    self.number_of > 0
  end

  # def active_user
  #   active_post&.user
  # end

  def active_users
    active_posts&.map { |post| post.user }
  end

  # def active_post
  #   posts.where(active: true).first
  # end

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

  def plus_number_of
    self.number_of += 1
  end

  def minus_number_of
    self.number_of -= 1
  end
end
