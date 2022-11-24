class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :destroy, :edit, :update]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @listings = Listing.search_by_title_and_description(params[:query])
    else
      @listings = Listing.where.not(user: current_user)
    end
  end

  # def index
  #   if params[:query].present?
  #     @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")
  #   else
  #     @movies = Movie.all
  #   end
  # end

  # def index
  #   @listings = Listing.all
  # end

  def new
    @listing = Listing.new
  end

  def show
    @booking = Booking.find_by(listing_id: @listing.id)
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.availability = true
    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    redirect_to dashboard_path, notice: "Listing was successfully destroyed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :rental_price, :availability, photos: [])
  end
end
