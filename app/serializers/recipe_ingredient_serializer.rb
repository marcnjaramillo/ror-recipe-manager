class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :quantity, :ingredient
  has_one :ingredient

  def ingredient
    object.ingredient.name
  end
end
