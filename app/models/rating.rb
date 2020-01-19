class Rating < ApplicationRecord
  validates :value, inclusion: (0..5)
  belongs_to :book
  belongs_to :user
end
