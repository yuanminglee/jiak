class MealsController < ApplicationController
  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    @meals = Meal.where(restaurant_id: restaurant)
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.new
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.new(meal_params)
    @meal.restaurant = restaurant
    @meal.save
    # if @meal.save
    #     redirect_to restaurant    
    # else
    #   render :new
    # end
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)
  end

  def destroy
    meal = Meal.find(params[:id])
    meal.destroy
    redirect_to root_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :ingredients, :price, :pax)
  end
end

