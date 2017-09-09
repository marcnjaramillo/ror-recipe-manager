class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: {in: 6..30}, unless: Proc.new { |user| user.uid.present? }
end
