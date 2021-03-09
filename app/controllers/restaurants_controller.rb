class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show edit update destroy orders]

  def index
    @restaurants = policy_scope(Restaurant).order(:id)
  end

  def show
    authorize @restaurant

    @order = Order.new
    @order.restaurant = @restaurant
  end

  def new
    authorize Restaurant

    @restaurant = Restaurant.new
  end

  def create
    authorize Restaurant

    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save!
      redirect_to restaurant_path(@restaurant)
    end
  end

  def edit
    authorize @restaurant
  end

  def update
    authorize @restaurant

    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    authorize @restaurant

    @restaurant.destroy
    redirect_to restaurants_path
  end

  def orders
    authorize @restaurant
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :address, :collection_time, :opening_days, :photo, :user_id)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
