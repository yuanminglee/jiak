class LineItemsController < ApplicationController
  def create
    @order = Order.find(params[:id])


    # @order.save!
    # redirect_to edit_restaurant_order_path(@restaurant, @order)
  end
end
