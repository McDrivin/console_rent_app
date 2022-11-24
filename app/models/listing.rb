class Listing < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
    against: [ :title, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  # multisearchable against: [:title, :description]

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :title, presence: true
  validates :description, presence: true
  validates :rental_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
