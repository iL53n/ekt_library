class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :image,
            :status, presence: true

  has_and_belongs_to_many :categories
  belongs_to :user, optional: true
  has_many :readings
  # has_one_attached :image

  scope :booking, ->(current_user) { where(status: 'Зарезервирована', user: current_user) }
  scope :reading, ->(current_user) { where(status: 'На руках', user: current_user) }
  scope :readed,  ->(current_user) { joins(:readings).where(readings: { user: current_user }) }
end
