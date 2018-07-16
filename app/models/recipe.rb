class Recipe < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :directions
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_one_attached :image

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :recipe_ingredients, presence: true
  validates :directions, presence: true

  accepts_nested_attributes_for :recipe_ingredients, reject_if: proc { |attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: proc { |attr| attr[:text].blank? }, allow_destroy: true

  scope :sorted, lambda {order("created_at DESC")}
  scope :search, lambda {|search| where(["name LIKE ?", "%#{search}%"])}

  def empty_children(attributes)
    attributes[:name].blank? && attributes[:quantity].blank?
  end
end
