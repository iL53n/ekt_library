class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :image,
            :status, presence: true

  has_and_belongs_to_many :categories
  # belongs_to :user, optional: true
  # has_many :readings
  # has_many :wishes
  # has_one_attached :image
  
  has_many :posts
  has_many :users, through: :posts

  # scope :booking, ->(current_user) { where(status: 'Зарезервирована', user: current_user) }
  # scope :reading, ->(current_user) { where(status: 'На руках', user: current_user) }
  # scope :readed,  ->(current_user) { joins(:readings).where(readings: { user: current_user }) }
  # scope :wishes,  ->(current_user) { joins(:wishes).where(wishes: { user: current_user }) }

  scope :booking, ->(current_user) { joins(:posts).where(posts: { title: 'booking', user: current_user, active: true }) }
  scope :reading, ->(current_user) { joins(:posts).where(posts: { title: 'reading', user: current_user, active: true }) }
  scope :readed,  ->(current_user) { joins(:posts).where(posts: { title: 'readed', user: current_user }) }
  scope :wishes,  ->(current_user) { joins(:posts).where(posts: { title: 'wish', user: current_user }) }

  def available?
    posts.where(active: true).nil?
  end

  def active_user
    active_post.user if posts.exists?
  end

  def active_post
    posts.exists? ? posts.where(active: true).first : nil
  end

  def close_active_post
    active_post.update!(active: false)
  end
end
