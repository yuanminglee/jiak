class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy, :orders]

  def index
    @restaurants = Restaurant.order(:id)
  end

  def show
    @order = Order.new
    @order.restaurant = @restaurant
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to restaurant_path(@restaurant)
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  def orders
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :address, :collection_time, :opening_days, :photo)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
