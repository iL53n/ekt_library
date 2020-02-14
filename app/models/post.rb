class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, inclusion: { in: %w[booking reading readed wish] }

  belongs_to :book
  belongs_to :user
end
