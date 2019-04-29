class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :user_id
end
