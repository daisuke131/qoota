class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :title, :body, presence: true
  enum status: [:published, :draft]
end
