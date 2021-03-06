class Restaurant < ApplicationRecord
  has_many :meals
  has_many :orders
  has_one_attached :photo
end