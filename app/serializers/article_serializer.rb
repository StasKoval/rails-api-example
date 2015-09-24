class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user_id
end
