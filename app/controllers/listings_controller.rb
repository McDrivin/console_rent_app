class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def show
    @booking = Booking.find_by(listing_id: @listing.id)
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.save
  end

  def edit
  end

  def update
    @listing = Listing.update(listing_params)
  end

  def destroy
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end
  def listing_params
    params.require(:listing).permit(:title, :description, :rental_price, :availability, photos: [])
  end
end
