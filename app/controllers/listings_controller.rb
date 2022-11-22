class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new[listing_params]
    @listing.save
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :rental_price)
  end

end
