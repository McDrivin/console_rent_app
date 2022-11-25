class BookingsController < ApplicationController
  def create
    @new_booking = Booking.new(booking_params)
    @listing = Listing.find(params[:listing_id].to_i)
    @listing.availability = true
    @new_booking.listing = @listing
    @new_booking.user_id = current_user.id
    @new_booking.total_price = (@new_booking.end_date - @new_booking.start_date) / 86_400 * @listing.rental_price

    if @new_booking.save
      @listing.save
      redirect_to booking_path(@new_booking)
    else
      render "listings/show", status: :unprocessable_entity
    end
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
