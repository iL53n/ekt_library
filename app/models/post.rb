class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, inclusion: { in: %w[booking reading readed wish] } # ToDo: why readed?

  belongs_to :book
  belongs_to :user
end
