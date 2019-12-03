class Book < ApplicationRecord

  validates :title,
            :author,
            :description,
            :image,
            :status, presence: true
end
