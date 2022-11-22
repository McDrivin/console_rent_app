class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true
  validates :rental_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
