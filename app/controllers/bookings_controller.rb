class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new[booking_params]
    @booking.save
  end

  def new
    @booking = Booking.new
  end


  def show
    @booking = Booking.new(booking_params)
  end

  def destroy
    if @booking.destroy
      redirect_to bookings_path(@booking)
    else
      render :index
    end
  end

  private

  def listing_params
    params.require(:booking).permit(:title, :description, :rental_price)
  # def booking_params
  # params[:booking] # index create new show destroy
  end
end
