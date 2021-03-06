class LineItemsController < ApplicationController
  before_action :find_line_item, only: %i[destroy]
  after_action :update_price, only: %i[destroy]

  def create
    @order = Order.find(params[:id])
  end

  def destroy
    @order = @line_item.order

    if @line_item.destroy
      redirect_to edit_order_path(@order), notice: "Item removed!"
    end
  end

  private

  def find_line_item
    @line_item = LineItem.find(params[:id])
  end
  
  def update_price
    @order = @line_item.order
    @order.update_total_price
  end
end
