class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, inclusion: { in: %w[booking reading wish] }

  belongs_to :book
  belongs_to :user
end
