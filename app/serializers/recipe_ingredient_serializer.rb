class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :ingredient, :quantity
  has_many :ingredients

  def ingredient
    return object.ingredient.name
  end
end
