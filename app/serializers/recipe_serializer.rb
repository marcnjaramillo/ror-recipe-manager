class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :prep_time, :cook_time
  has_many :recipe_ingredients
  has_many :directions
end
