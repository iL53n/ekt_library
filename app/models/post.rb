class Post < ApplicationRecord
  validates :title, inclusion: { in: %w[booking reading readed wish] }

  belongs_to :book
  belongs_to :user
end
