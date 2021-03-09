class OrdersController < ApplicationController
  before_action :find_order, only: %i[show edit update update_price cancel confirm]
  after_action :update_price, only: %i[update]

  def show
    authorize @order

    @grouped_line_items = @order.line_items.group_by(&:meal).map do |meal, line_items|
      {
        name: meal.name,
        images: [meal.photo.url],
        amount: meal.price_cents,
        currency: 'sgd',
        quantity: line_items.sum(&:quantity)
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @grouped_line_items,
      success_url: order_url(@order),
      cancel_url: order_url(@order)
    )

    @order.update(checkout_session_id: session.id)
    flash[:notice] = "Thanks for your payment. Your order is confirmed!"
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'Draft'

    authorize @order

    @order.save!
    redirect_to edit_order_path(@order)
  end

  def edit
    @restaurant = @order.restaurant
    @meals = @restaurant.meals

    authorize @order
  end

  def update
    authorize @order

    @order.line_items.build(order_params[:line_item])

    if @order.save!
      redirect_to edit_order_path(@order), notice: "#{@order.line_items.last.quantity} x #{@order.line_items.last.meal.name} added!"
    else
      flash[:alert] = "Order not saved"
    end
  end

  def cancel
    authorize @order

    @order.update(status: 'Cancelled')
    redirect_to restaurant_path(@order.restaurant), notice: "Your order is cancelled!"
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
