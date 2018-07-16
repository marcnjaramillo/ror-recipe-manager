class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
end
