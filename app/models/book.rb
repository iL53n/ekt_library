class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :image,
            :status, presence: true

  has_and_belongs_to_many :categories
  belongs_to :user, optional: true
  # has_one_attached :image
end
