class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def create
    @booking = Booking.new(booking_params)
    @listing = Listing.find(params[:listing_id].to_i)
    @listing.availability = true
    @booking.listing = @listing
    @booking.user = current_user
    @booking.total_price = (@booking.end_date - @booking.start_date) / 86_400 * @listing.rental_price

    if @booking.save
      @listing.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def show
    @booking = Booking.find(params[:id])
    @listing = Listing.find(@booking.listing_id)
  end

  def destroy
    if @booking.destroy
      redirect_to bookings_path(@booking)
    else
      render :index
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
