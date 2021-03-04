class MealsController < ApplicationController
  before_action :find_meal, only: [:show, :edit, :update, :destroy]
  before_action :find_restaurant, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @meals = Meal.where(restaurant_id: @restaurant)
  end

  def show; end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.restaurant = @restaurant
    @meal.save
    if @meal.save
      redirect_to restaurant_meals_path(@restaurant)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @meal.update(meal_params)
      redirect_to restaurant_meals_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to restaurant_meals_path(@restaurant)
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :ingredients, :price, :pax)
  end

  def find_meal
    @meal = Meal.find(params[:id])
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
