class ReviewsController < ApplicationController
  before_action :find_restaurant, only: %i[index create]

  def index
    @reviews = policy_scope(Review)
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.restaurant = @restaurant

    authorize @review

    if @review.save
      redirect_to restaurant_reviews_path(@restaurant, anchor: "review-#{@review.id}")
    else
      render :index
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_reviews_path(@restaurant, anchor: "review-#{@review.id}")
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
