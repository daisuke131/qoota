class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # ,:confirmable,:omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, presence: true
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
end
