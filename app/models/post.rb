class Post < ApplicationRecord
  validates :title, inclusion: { in: %w[booking reading readed wish_list] }

  belongs_to :book
  belongs_to :user
end
