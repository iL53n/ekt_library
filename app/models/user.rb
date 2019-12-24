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

  #has_many :books
  has_many :readings
  has_many :wishes

  has_many :posts
  has_many :books, through: :posts
end
