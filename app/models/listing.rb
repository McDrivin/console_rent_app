class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :title, presence: true
  validates :description, presence: true
  validates :rental_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
