class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :orders
  has_one_attached :photo
end
