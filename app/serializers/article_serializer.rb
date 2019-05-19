class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status
  has_one :user
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
