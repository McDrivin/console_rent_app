class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @listings = Listing.where.not(user: current_user).first(4)
  end

  def dashboard
    @listings = Listing.where(user_id: current_user.id)
    @bookings = Booking.where(user_id: current_user.id)
  end
end
