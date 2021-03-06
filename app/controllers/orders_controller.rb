class OrdersController < ApplicationController
  before_action :find_order, only: %i[edit update]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'Draft'

    @order.save!
    redirect_to edit_order_path(@order)
  end

  def edit
    @restaurant = @order.restaurant
    @meals = @restaurant.meals
  end

  def update
    @order.line_items.build(order_params[:line_item])

    if @order.save!
      redirect_to edit_order_path(@order), notice: "#{@order.line_items.last.quantity} x #{@order.line_items.last.meal.name} added!"
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:collection_date, :restaurant_id, line_item: [:meal_id, :quantity])
  end
end
