class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 10 }
  validates :description, presence: true, length: { minimum: 5, maximum: 50 }
  validates :price, presence: true, numericality: true
end
