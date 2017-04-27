class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :quantity
  has_many :ingredients
end
