class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  validates :first_name,
            :last_name,
            :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :books, through: :posts
  has_many :comments
  has_many :ratings

  def voted?(book)
    book.ratings.where(user_id: self.id).exists?
  end
end
