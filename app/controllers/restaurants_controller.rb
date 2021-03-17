class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show edit update destroy orders]

  def index
    if params[:search].present?
      filters = params[:search][:filters].reject(&:empty?)
      query = params[:search][:query]

      @restaurants = policy_scope(Restaurant)
      @restaurants = @restaurants.global_search(query) if query.present?
      @restaurants = @restaurants.select { |restaurant| (filters - restaurant.opening_days).empty? } if filters.present?

      prefix = ' for ' if query.present?
      @search_placeholder = "Displaying #{@restaurants.count} #{'result'.pluralize(@restaurants.count)}#{prefix}#{query if query.present?}"
    else
      @restaurants = policy_scope(Restaurant).order(:id)
    end
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
      redirect_to owned_restaurants_path
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

  def owned
    @restaurants = current_user.restaurants
    authorize @restaurants
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
