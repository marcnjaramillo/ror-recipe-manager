class UserSerializer < ActiveModel::Serializer
  attributes :username
  has_many :comments
end
