class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :name, presence: true

  accepts_nested_attributes_for :recipe_ingredients, :directions

  scope :sorted, lambda {order("created_at DESC")}
  scope :search, lambda {|search| where(["name LIKE ?", "%#{search}%"])}
end
