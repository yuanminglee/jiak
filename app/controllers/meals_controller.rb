class MealsController < ApplicationController
  before_action :find_meal, only: %i[edit update]
  before_action :find_restaurant, only: %i[new create edit update]
  before_action :authorize_meal, except: :new

  def new
    @meal = Meal.new
    @meal.restaurant = @restaurant

    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.restaurant = @restaurant
    @meal.save
    if @meal.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to restaurant_meals_path(@restaurant)
    else
      render :edit
    end
  end

  private

  def authorize_meal
    authorize @meal
  end

  def meal_params
    params.require(:meal).permit(:name, :description, :ingredients, :price, :pax, :photo)
  end

  def find_meal
    @meal = Meal.find(params[:id])
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
