class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, date: { before: :end_date }
  validates :end_date, date: { after: :start_date }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
