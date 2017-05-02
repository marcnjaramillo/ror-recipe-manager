class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients, dependent: :destroy

  validates :name, uniqueness: {case_sensitive: false}

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
end
