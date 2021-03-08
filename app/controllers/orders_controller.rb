class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit update update_price cancel confirm]
  after_action :update_price, only: %i[update]

  def show
    @grouped_line_items = @order.line_items.group_by(&:meal)
  end

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

  def cancel
    @order.update(status: 'Cancelled')
    redirect_to restaurant_path(@order.restaurant), notice: "Your order is cancelled!"
  end

  def confirm
    @order.update(status: 'Confirmed')
    redirect_to order_path(@order), notice: "Your order is confirmed!"
  end

  private

  def update_price
    @order.update_total_price
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:collection_date, :restaurant_id, :status, line_item: [:meal_id, :quantity])
  end

end
