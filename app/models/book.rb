class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :image,
            :status, presence: true

  has_and_belongs_to_many :categories
  # has_one_attached :image
end
