class Restaurant < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :meals
  has_many :orders
  has_many :reviews
  has_one_attached :photo

  validates_inclusion_of :opening_days, in: Date::DAYNAMES

  pg_search_scope :global_search,
                  against: %w[name description],
                  associated_against: {
                    meals: %w[name ingredients]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
