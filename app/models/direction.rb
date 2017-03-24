class Direction < ApplicationRecord
  belongs_to :recipe, optional: true
end
