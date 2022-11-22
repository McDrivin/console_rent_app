class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def show
    @listing = Listing.find(params[:id])
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
