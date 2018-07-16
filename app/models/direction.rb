class Direction < ApplicationRecord
  belongs_to :recipe, optional: true
  validates :text, presence: true
end
