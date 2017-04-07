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

  def empty_children(attributes)
    attributes['name'].blank? && attributes['quantity'].blank?
  end
end
