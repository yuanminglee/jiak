class Restaurant < ApplicationRecord
  has_many :meals
  has_many :orders
end
