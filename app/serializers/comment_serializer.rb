class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :recipe
  has_one :user
end
