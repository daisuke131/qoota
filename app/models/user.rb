class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
end
