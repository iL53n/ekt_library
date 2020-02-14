class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :status, presence: true

  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def calculate_rating
    ratings.sum(&:value) / ratings.count if ratings.any?
  end

  def available?
    !posts.where(active: true).exists?
  end

  def active_user
    active_post&.user
  end

  def active_post
    posts.where(active: true).first
  end

  def close_active_post
    active_post&.update!(active: false, end_date: Time.now)
  end
end
