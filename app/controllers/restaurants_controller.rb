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
    @orders = @restaurant.orders.order(:collection_date)
  end

  private

  def restaurant_params
    params[:restaurant][:opening_days].reject!(&:empty?)

    params.require(:restaurant).permit(
      :name, :description, :address, :collection_time, :photo, :user_id, opening_days: []
    )
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
