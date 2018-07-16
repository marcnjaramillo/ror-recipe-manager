class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :content, presence: true
end
