class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :user_id
  has_many :likes
end
