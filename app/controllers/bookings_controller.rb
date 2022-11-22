class BookingsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def create
    @booking = Booking.new[booking_params]
    @listing = Listing.find(params[:listing_id])
    @booking.listing = @listing
    if @booking.save
      redirect_to listing_path(@listing)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @booking = Booking.new
  end

  def show
    raise
    @booking = Booking.find(params[:id])
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
    params.require(:booking).permit(:listing_id, :user_id, :start_date, :end_date, :total_price)
  # def booking_params
  # params[:booking] # index create new show destroy
  end
end

  # def create
  #   @bookmark = Bookmark.new(bookmark_params)
  #   @list = List.find(params[:list_id])
  #   @bookmark.list = @list
  #   if @bookmark.save
  #     redirect_to list_path(@list)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end
