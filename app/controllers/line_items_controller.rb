class LineItemsController < ApplicationController
  def create
    @order = Order.find(params[:id])
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @order = @line_item.order

    if @line_item.destroy
      redirect_to edit_order_path(@order), notice: "Item removed!"
    end
  end
end
