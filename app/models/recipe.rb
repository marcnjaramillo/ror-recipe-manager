class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :user, foreign_key: "user_id"

  validates :name, presence: true

  accepts_nested_attributes_for :recipe_ingredients, :reject_if => proc { |att| att['name'].blank? && att['quantity'].blank? }
  accepts_nested_attributes_for :directions, :reject_if => proc { |att| att['text'].blank? }

  scope :sorted, lambda {order("created_at DESC")}
  scope :search, lambda {|search| where(["name LIKE ?", "%#{search}%"])}

  def ingredients_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |ingredient_attribute|
      if ingredient_attribute[:name] != ""
        ingredient = Ingredient.find_or_create_by(name: ingredient_attribute[:name])
        self.ingredients << ingredient unless self.ingredients.include?(ingredient)
      end
    end
  end

  def empty_children(attributes)
    attributes['name'].blank? && attributes['quantity'].blank?
  end
end
