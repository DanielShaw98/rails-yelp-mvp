class ReviewsController < ApplicationController
  before_action :set_restaurant, only: %i[new create]

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!
    redirect_to restaurant_path(@review.restaurant), notice: "Review was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:content, :rating, :restaurant_id)
    end
end
