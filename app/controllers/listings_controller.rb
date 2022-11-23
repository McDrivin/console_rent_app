class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

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
    @listing = Listing.new(listing_params)
    # raise
    @listing.user = current_user
    if  @listing.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :rental_price, photos: [])
  end
end
